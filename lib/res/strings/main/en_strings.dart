import 'package:g_base_package/base/lang/localization.dart';

import '../../../utils/constants.dart';
import '../string_keys.dart';

///English translations, each new String must be also added to the other
///translation files and the key must be a constant.
///
/// For translators: The text is split into sections by screens, please translate only the text in '' after :
/// For example: StrKey.appName: 'Teachers',
/// The text in quotes is the text shown to the user : 'Teachers'
/// The text before the : is the key to find the correct text in each translation files : StrKey.appName
/// If you see %s, %d or % as prefix to something, this is a place holder and the app will put something on it,
/// you can change the position according to the current language, but the place holder must be there always.
/// %s is for text, %d is for number and so on.
/// For example StrKey.lblRangeTasks: 'From : %s - To : %s', in the app will be something like :
/// 'From : 16.02.21 - To : 17.02.21'
/// If you want to add quotes in the text, they must be prefixed with \ , for example 'Service Company : \'%s\''.
/// This will be presented like : 'Service Company : 'Polar''.
/// If you want to split the text on next line use \n for new line.
class EnUSStrings extends AppLocale {
  @override
  Map<String, String> get localizedStrings {
    return const {
      //Common
      StrKey.SUPPORT_ITEM_SHOW_LICENSES: "Show licenses",
      StrKey.ERROR_PARAGRAPH_401_NO_OR_INVALID_CREDENTIALS: "Check your username and password to continue.",
      StrKey.ERROR_PARAGRAPH_403_NOT_ENOUGH_PRIVILEGES: "Looks like you don't have the access rights to continue.",
      StrKey.ERROR_PARAGRAPH_500_INTERNAL_SERVER_ERROR: "It seems we've hit a hurdle on the way... You shouldn't be seeing this message. But if you keep seeing it, please contact Polar Customer Care.",
      StrKey.ERROR_PARAGRAPH_404_PAGE_NOT_FOUND: "Sorry, looks like we took a wrong turn somewhere! If you keep getting this message, please contact Polar Customer Care.",
      StrKey.ERROR_PARAGRAPH_NO_NETWORK: "Could not connect to network. Check your connection.",

      
      //Login screen
      StrKey.LOGIN_WELCOME_TITLE: 'Welcome to Start App',
      StrKey.ERROR_EMPTY_EMAIL_OR_PASSWORD: 'Empty field',
      StrKey.ERROR_AUTHENTICATE: 'Check your email',
      StrKey.ERROR_PASSWORD_PATTERN: 'Check your password.\nIts minimum length is\n8 characters.',
      StrKey.ERROR_INVALID_EMAIL_OR_PASSWORD:
          'We couldn\'t find the user, or the password is incorrect. Please try again.',
      StrKey.ERROR_INVALID_EMAIL_OR_PASSWORD_HEADER: 'Check your username and password',
      StrKey.COMMON_EMAIL: 'Email',
      StrKey.COMMON_PASSWORD: 'Password',
      StrKey.BUTTON_SIGN_IN: 'Sign in',

      //Home screen
      StrKey.HOME_TITLE: 'Home',
      StrKey.BUTTON_LOG_OUT: 'Sign out',
      StrKey.BUTTON_LOAD: 'Load',
      StrKey.LBL_ORGANIZATIONS: 'Organizations',
      StrKey.LBL_NAME: 'Name',
      StrKey.LBL_CLASSES: 'Classes',
      StrKey.LBL_MEMBERS: 'Members',
    };
  }

  @override
  String get languageCode => Constants.LOCALE_EN_US;
}
