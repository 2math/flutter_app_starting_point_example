import 'package:equatable/equatable.dart';

///The is the bloc state of the login screen. All the information that we need to build the screen should be here.
class LoginState extends Equatable {
  final bool? isLoginSuccessfully;
  final String? errorUsername, errorPassword;
  final bool showProgress;
  final dynamic error;

  const LoginState({
    required this.isLoginSuccessfully,
    required this.showProgress,
    required this.errorUsername,
    required this.errorPassword,
    required this.error,
  });

  ///This is how our state will looks like on start.
  factory LoginState.initial() {
    return const LoginState(
      isLoginSuccessfully: null,
      showProgress: false,
      errorUsername: null,
      errorPassword: null,
      error: null,
    );
  }

  ///Copy with function to update only a part of the state.
  LoginState copyWith({
    bool? isLoginSuccessfully,
    bool? showProgress,
    String? errorUsername,
    String? errorPassword,
    bool canClearUsernameError = false,
    bool canClearPasswordError = false,
    dynamic error,
  }) {
    return LoginState(
        //If isLoginSuccessfully was send update it, else use current value.
        isLoginSuccessfully: isLoginSuccessfully ?? this.isLoginSuccessfully,
        showProgress: showProgress ?? this.showProgress,
        //If errorUsername is not null replace it, other way if we set canClearUsernameError = true,
        //clear the error. Other way we probably didn't send the errorUsername and must remain as is.
        //This is because we show the error as a widget under the field and not as a popup dialog.
        errorUsername: errorUsername ?? (canClearUsernameError ? null : this.errorUsername),
        errorPassword: errorPassword ?? (canClearPasswordError ? null : this.errorPassword),
        //The error should be one time event, so on each state change will be cleared.
        //If we set an error will be updated other way clear it to prevent multiple times of showing the error.
        error: error);
  }

  @override
  List<Object?> get props => [
        //Here we must point out which fields of the class should be used for comparison.
        //It is been used to detect state changes between current and new state.
        isLoginSuccessfully,
        showProgress,
        error,
        errorUsername,
        errorPassword,
      ];

  @override
  String toString() {
    return 'LoginState{'
        'isLoginSuccessfully: $isLoginSuccessfully, '
        'errorUsername: $errorUsername, '
        'errorPassword: $errorPassword, '
        'showProgress: $showProgress, error: $error}';
  }
}
