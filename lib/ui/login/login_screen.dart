import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_base_package/base/lang/localization.dart';
import 'package:g_base_package/base/utils/logger.dart';
import 'package:g_base_package/base/utils/system.dart';
import 'package:g_base_package/base/widgets/single_scroll_view.dart';
import '../../res/res.dart';
import '../../utils/ui_utils.dart';
import '../base/app_base_state.dart';
import '../home/home_screen.dart';
import 'bloc/bloc.dart';

class LoginPage extends StatelessWidget {
  //Our Parent widget is a state less widget, we only use it as a shelf to provide the Login bloc to any widget
  // inside it.
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //The body of that widget is a Bloc provider which will init the Login bloc if doesn't has it yet and then for
    // each widget that has the Login screen as a parent is able to access it.
    return BlocProvider<LoginBloc>(create: (context) => LoginBloc(), child: _LoginPage());
  }
}

class _LoginPage extends StatefulWidget {
  //This is our actual screen
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends AppBaseState<_LoginPage> {
  //This is the state of our screen
  late LoginBloc _bloc;
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _usernameTextEditingController = TextEditingController(text: '');
  final TextEditingController _passwordTextEditingController = TextEditingController(text: '');
  bool _passwordVisible = false;

  //This is our tag to be used for the logs, crashes or analytics.
  @override
  String get tag => 'LoginPage';

  @override
  void initState() {
    super.initState();
    //Here is our initialization of the screen state. It is called just once and is a good time to do our
    // initialization logic after the super is initialized.

    //This is how we get the bloc created in the parent. With this approach we can access the bloc from any widget
    // inside the parent.
    _bloc = BlocProvider.of<LoginBloc>(context);

    //In our state we have local and remote repositories injected for us. Here in the initialization we check if
    // there are any credentials saved and populate the form field with them.
    localRepository!.getCredentials().then((credentials) {
      //If we have any username add it. On logout we only delete the users password, so next time when open the app
      // his username will be still available and populated.
      _usernameTextEditingController.text = credentials.email ?? '';

      if (kDebugMode) {
        //Currently there is no auto login. Other way in bloc constructor we will try to login if we have a password.
        //So every time the app is reopened will ask for a password, no mater if you did a logout. This is a business
        //logic from PGF app.
        //However if we are in debug mode, lets populate the saved password for quicker work.
        _passwordTextEditingController.text = credentials.password ?? '';
      }
    });
  }

  @override
  void dispose() {
    //This is a state function which will be called before the widget to be disposed. Here we should clear any
    // resources that could memory leak. In general when this function is called another widget(screen) has already
    // been called and is visible, so this widget is not visible anymore.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //This is our build function which returns a widget that represent our screen.
    if (SizeConfig().init(context)) {
      //SizeConfig will init anytime the screen size has changed and update the sizes.
      //It is good to call it on each screen widget if we want dynamic sizes, other way is enough to be called on
      // first screen only as will get the original screen sizes.

      //This is how we log data in the console. Is part of the SDK and has multiple levels of logging.
      //It takes care if the build is in release mode to not log data. At the same time if we have a crash reporter
      // will store latest logs for it to be sent on crash.
      Log.d(SizeConfig().toString());
    }

    //Our screen is surrounded by SafeArea widget, which makes sure the space we use is not going under the system
    // bars as status bar on top or navigation bar on the bottom. It could be also on the sides if the screen has
    // reserved parts like edges on some Samsung devices.
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          //The gesture detector is used to consume clicks over non clickable widgets.
          //Currently will remove the focus on current input field and hide the keyboard if was visible.
          removeCurrentFocus(context);
        },
        //Scaffold is the widget that represent one screen. We can add app bar, drawer, floating buttons and etc on it.
        child: Scaffold(
          backgroundColor: AppColors.appBackground,
          body: setBody(),
        ),
      ),
    );
  }

  Widget setBody() {
    //Our bloc consumer is a special widget that will be refreshed by the bloc if its state is changed.
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        //This listener will be called if there were any changes in the state. Here we want to do some actions
        // related to the changes, like show progress or error message and so on.
        _handleStateChanges(context, state);
      },
      builder: (context, state) {
        //This function will be also called when the state was changed and expects as e return value a widget the
        // will be shown on the screen. So we change our screen related to new changes of the state.
        return _body(context, state);
      },
    );
  }

  Widget _body(BuildContext context, LoginState state) {
    //Our body is a container that holds the login form, centered inside of a scrollable widget,
    //so when a keyboard appear our content will be scrollable and we will be able to access each
    //input fields in the form.
    return SingleScrollView(
      child: Center(
        child: Container(
          //Depending of our screen orientation the login from will be 40% or 80% of current screen width.
          width: Dimen.screenHorizontalFull * (Dimen.isLandscape ? 0.4 : 0.8),
          //Add white background and rounded corners to our container
          decoration: const BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(Dimen.cornersSmall))),
          child: Padding(
            padding: EdgeInsets.all(Dimen.paddingNormal),
            //We use a column to layout our widgets one under each other
            child: Column(
              //Option to set the column to take only the space that is needed for it, if is max(by default)
              //will stretch by length and take entire space.
              mainAxisSize: MainAxisSize.min,
              children: [
                _polarLogo(),
                //This is predefined in the SDK size widget(SizeBox), which we use to add similar spaces all over the
                //apps. You have tiny, micro, small, normal, big, xBig and xxBig sizes, as each has H(by height) or
                // W(by width). So in columns we use normalSpaceH, while in rows use normalSpaceW.
                Style.normalSpaceH,
                //Our title using localized string by its string key. It is taken from current localization set.
                Text(
                  Txt.get(StrKey.LOGIN_WELCOME_TITLE),
                  //We have predefined styles in the SDK. Currently we use the default for bold text, but because the
                  // font size in that style is regular text size, we update it with a bigger size. Which is also
                  // predefined in the SDK.
                  style: Style.boldText.copyWith(fontSize: Dimen.xBigText),
                ),
                Style.smallSpaceH,
                _username(state),
                Style.smallSpaceH,
                _password(state),
                Style.normalSpaceH,
                _loginBtn(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SvgPicture _polarLogo() {
    //Example how to load an svg image.
    return SvgPicture.asset(
      Img.icLogo,
      //Take 30% of screen width.
      width: Dimen.screenHorizontalFull * 0.3,
      //Resize the image to fit by width(the height is dynamic).
      fit: BoxFit.fitWidth,
    );
  }

  Widget _loginBtn() {
    //We use a predefined widget from our SDK for rounded button.
    return UiUtils.buildRoundedButton(
      color: AppColors.btnMain,
      corners: Dimen.cornersHuge,
      //Pass the login function as a reference.
      onClickAction: _login,
      child: Padding(
        padding: EdgeInsets.all(Dimen.paddingMicro),
        child: Text(
          Txt.get(StrKey.BUTTON_SIGN_IN).toUpperCase(),
          style: Style.btnText,
        ),
      ),
    );
  }

  void _login() {
    //Our login function is called from 2 places. From login button and from password input field when you click on
    //the Go button on the keyboard.
    _bloc.doLogin(_usernameTextEditingController.text.trim(), _passwordTextEditingController.text.trim());
  }

  TextFormField _username(LoginState state) {
    //This is our input field for the username, which in our case is an email.
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.next,
      //Predefined style in the SDK
      style: Style.etText,
      //This controller is giving an access to the text value in the field.
      controller: _usernameTextEditingController,
      cursorColor: AppColors.regularText,
      //Predefined decoration in the SDK
      decoration: UiUtils.etInputDecorationUnderline(
        hint: Txt.get(StrKey.COMMON_EMAIL),
        //If we have set an error in the state, will be shown under the field and change the border to red. If the error
        //is null will be cleared from the field.
        error: state.errorUsername,
      ),
      onFieldSubmitted: (String value) {
        //If is allowed save the username value as a log in the crash reporter
        Log.d("option - $value", tag);
        //This callback is called when we click the enter button on the keyboard.
        //In that case first we check if the username in the field is valid.
        //If is not valid will show an error message, else will clear the message if there was one.
        if (_bloc.validateUsername(value)) {
          //On valid username will change the focus to the password field.
          //fieldFocusChange function is part of the BaseState from the SDK.
          fieldFocusChange(context, _usernameFocusNode, _passwordFocusNode);
        }
      },
      //set a focus not to the field so we can pass the focus to or from that field.
      focusNode: _usernameFocusNode,
    );
  }

  TextFormField _password(LoginState state) {
    return TextFormField(
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.go,
      obscureText: !_passwordVisible,
      style: Style.etText,
      controller: _passwordTextEditingController,
      cursorColor: AppColors.regularText,
      decoration: UiUtils.etInputDecorationUnderline(
          hint: Txt.get(StrKey.COMMON_PASSWORD),
          error: state.errorPassword,
          //Add a suffix button to control if the password is visible or not.
          suffixIcon: IconButton(
            icon: Icon(
              //Change the icon depending on _passwordVisible value.
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: AppColors.hintText,
            ),
            onPressed: () {
              //Here we use the default Flutter state management to refresh the screen instead of the Bloc pattern.
              //setState is a function in StateFull widgets that will execute the callback inside to make the changes
              //and ask the widget to redraw(call build()).
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )),
      onFieldSubmitted: (String value) {
        //Do not save the password value in the crash reporter
        Log.d("option - $value", tag);
        if (_bloc.validatePassword(value)) {
          //On valid password we try to login with current username and password. The logic is handled in bloc.
          _login();
        }
      },
      focusNode: _passwordFocusNode,
    );
  }

  void _handleStateChanges(BuildContext context, LoginState state) {
    //This is a function that is called on bloc state changes. According to some values in the state will do some UI
    // logic.

    if (state.showProgress) {
      //We set the showProgress to true. If the blocking progress is not shown already show it.
      //This function is part of the PolarBaseState in the SDK.
      showProgressIndicatorIfNotShowing();
    } else {
      //In case the blocking progress is visible hide it.
      hideProgressIndicator();
    }

    if (state.error != null) {
      //If we have an error, show it with the default mechanism in PolarBaseState. We can do our own handling here
      //though and if is not handled then to rely on the default implementation.
      //The error in the state is a onetime field. That means when we set an error in the state will exist only once,
      //next time when we update the state, this error will be gone. This way we prevent us of showing the same
      //error multiple times on state changed.
      showError(state.error);
    }

    if (state.isLoginSuccessfully == true) {
      //This is also one time event. We redirect to new screen and remove all previous screens(currently only this
      //screen), so the new screen(HomePage) becomes the root widget.
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
    }
  }
}
