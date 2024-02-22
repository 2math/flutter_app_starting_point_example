import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_base_package/base/app_exception.dart';
import 'package:g_base_package/base/lang/localization.dart';
import 'package:g_base_package/base/provider/instance_provider.dart';
import 'package:g_base_package/base/utils/extensions.dart';
import 'package:g_base_package/base/utils/logger.dart';

import '../../../res/strings/string_keys.dart';
import '../../base/app_base_bloc.dart';
import 'bloc.dart';

///This is our bloc for the Login screen. It consumes LogEvent events and emits LoginState to the LoginPage screen.
///Our business logic should be implemented here.
class LoginBloc extends AppBaseBloc<LoginEvent, LoginState> {
  @override
  String get tag => "LoginBloc";

  ///Our constructor can accept initial state, this is optional for unit tests when we want to test the block against
  /// some specific state.
  LoginBloc({LoginState? initialState}) : super(initialState ?? LoginState.initial()) {
    //From Bloc version 7.2.x you can subscribe to events with "on" function.
    //We create one common _onEvent function that replaces mapEventToState, but does the same.
    //You can use either "on" or "mapEventToState" function but not both.
    on<ShowProgress>((event, emit) => _onEvent(event, emit));
    on<HideProgress>((event, emit) => _onEvent(event, emit));
    on<OnInvalidPassword>((event, emit) => _onEvent(event, emit));
    on<OnInvalidUsername>((event, emit) => _onEvent(event, emit));
    on<OnLoginSuccessfully>((event, emit) => _onEvent(event, emit));
    on<OnError>((event, emit) => _onEvent(event, emit));
  }

  ///This is the function that will be called when someone call add(LoginEvent).
  ///Here we check what the event is and change the state related to it. Then emit the state to the UI.
  ///The block mechanism will do a comparison btw current and new state and if there are no changed will not
  ///emit it to the UI. The state it self is equitable and can do quick comparisons.
  _onEvent(LoginEvent event, Emitter<LoginState> emitter) {
    Log.d("$event", "$tag event");
    if (event is ShowProgress) {
      //here the event was ShowProgress so we change on the current state only that field to true and emit it to the UI.
      emitter(state.copyWith(showProgress: true));
    } else if (event is HideProgress) {
      emitter(state.copyWith(showProgress: false));
    } else if (event is OnInvalidPassword) {
      emitter(state.copyWith(errorPassword: event.error, canClearPasswordError: true));
    } else if (event is OnInvalidUsername) {
      emitter(state.copyWith(errorUsername: event.error, canClearUsernameError: true));
    } else if (event is OnLoginSuccessfully) {
      emitter(state.copyWith(isLoginSuccessfully: event.isLoginSuccessfully, showProgress: false));
    } else if (event is OnError) {
      emitter(state.copyWith(showProgress: false, error: event.error));
    }
  }

  @override
  Future<void> close() {
    //Here we can clear resources which could memory leak.
    return super.close();
  }

  ///This is the function that will be called when someone call add(LoginEvent).
  ///Here we check what the event is and change the state related to it. Then emit the state to the UI.
  ///The block mechanism will do a comparison btw current and new state and if there are no changed will not
  ///emit it to the UI. The state it self is equitable and can do quick comparisons.
  ///This is the way Bloc works until version 8.x.x
// @override
// Stream<LoginState> mapEventToState(LoginEvent event) async* {
//   Log.d("$event", "$tag event");
//
//   if (event is ShowProgress) {
//     //here the event was ShowProgress so we change on the current state only that field to true and emit it to the UI.
//     yield state.copyWith(showProgress: true);
//   }
//
//   if (event is HideProgress) {
//     yield state.copyWith(showProgress: false);
//   }
//
//   if (event is OnInvalidPassword) {
//     yield state.copyWith(errorPassword: event.error, canClearPasswordError: true);
//   }
//
//   if (event is OnInvalidUsername) {
//     yield state.copyWith(errorUsername: event.error, canClearUsernameError: true);
//   }
//
//   if (event is OnLoginSuccessfully) {
//     yield state.copyWith(isLoginSuccessfully: event.isLoginSuccessfully, showProgress: false);
//   }
//
//   if (event is OnError) {
//     yield state.copyWith(showProgress: false, error: event.error);
//   }
// }

  bool doLogin(String username, String password) {
    //We are about to do a server login. First lets check if the progress is not showed.
    if (state.showProgress) {
      //Currently the progress is shown which means we are doing the server call already and this is probably a
      // double click on the button that happened for some reason before to show the blocking progress on the screen.
      Log.d("we are doing Login already...", tag);
      return false;
    }

    //Check together username and password, both will update the state and produce or clear its error.
    //Also if any is not valid will stop the login process.
    if (!validateUsername(username) | !validatePassword(password)) {
      //form is not valid
      return false;
    }

    //If we are here means our form is valid and we should do the login with the server. So we show blocking progress
    // to make sure the user will not login twice.
    add(ShowProgress());

    //We have the remote repo injected for us already in the PolarBaseBloc, so we call login.
    remoteRepository!.login(username, password).then((session) async {
      //This is our callback if there were no errors.
      Log.d("result $session", tag);

      if (session != null) {
        //successful login
        InstanceProvider.getInstance()?.analyticsUtil?.logLogin();
      }

      //We will update the UI if the login was OK, if it was the LoginPage will redirect to the HomePage.
      add(OnLoginSuccessfully(session != null));
    }).catchError((error) {
      //This is our callback if an error was thrown.
      // If the error is PolarAppException it means was thrown by the app or sdk code. Other way is something unexpected
      if (error is AppException && error.code == 404) {
        //This is manual handling of the error. If the response code is 404, it means invalid login so we send to the
        // UI custom error with predefined title and message.
        add(OnError(error: AppException(errorMessage: Txt.get(StrKey.ERROR_INVALID_EMAIL_OR_PASSWORD))));
      } else {
        //This is generic handling of the error. The UI will use the default logic to show either predefined error
        // messages in the AppBaseConfig or the original error(something really unexpected and handy for the dev team)
        add(OnError(error: error));
        //This is how we log the error, if we have a crash reporter will send this error as non fatal error to it.
        Log.error("Login error", tag: tag, error: error);
      }
    });

    Log.d("login", tag);
    return true;
  }

  ///Function to detect if the username is not empty or is invalid email.
  ///If the conditions are not met will update the state, otherwise will clear previous error if there was one.
  bool validateUsername(String value) {
    if (value.isEmpty) {
      add(OnInvalidUsername(Txt.get(StrKey.ERROR_EMPTY_EMAIL_OR_PASSWORD)));
      return false;
    } else if (!value.isEmail()) {
      add(OnInvalidUsername(Txt.get(StrKey.ERROR_AUTHENTICATE)));
      return false;
    }

    add(const OnInvalidUsername(null));
    return true;
  }

  ///Function to detect if the password is not empty or is at least 8 characters.
  ///If the conditions are not met will update the state, otherwise will clear previous error if there was one.
  bool validatePassword(String value) {
    if (value.isEmpty) {
      add(OnInvalidPassword(Txt.get(StrKey.ERROR_EMPTY_EMAIL_OR_PASSWORD)));
      return false;
    } else if (!value.isValidLength(8)) {
      add(OnInvalidPassword(Txt.get(StrKey.ERROR_PASSWORD_PATTERN)));
      return false;
    }

    add(const OnInvalidPassword(null));
    return true;
  }
}
