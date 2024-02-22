import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:g_base_package/base/lang/localization.dart';
import 'package:g_base_package/base/provider/instance_provider.dart';
import 'package:g_base_package/base/reporters/analytics.dart';
import 'package:g_base_package/base/reporters/crash_reporter.dart';

import 'repository/local_repository.dart';
import 'repository/persistence/shared_preferences_helper.dart';
import 'repository/remote_repository.dart';
import 'res/res.dart';
import 'res/strings/main/en_strings.dart';
import 'ui/login/login_screen.dart';

///Run the app from entry points in the flavours folder.

class MainApp {
  run() async {
    //This must be initialized before Firebase!
    WidgetsFlutterBinding.ensureInitialized();

    //Option to lock to specific screen orientation, for iOS tablets check require fullscreen option from XCode
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      // DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) async {
      await init();

      runApp(materialApp(Style.appTheme));
    });
  }

  MaterialApp materialApp(ThemeData theme) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: theme,
      home: const LoginPage(),
    );
  }

  Future init() async {
    //int shared prefs
    await SharedPreferencesHelper.init();

    //Create instances of local and remote repositories that will be used all over the app.
    LocalRepository localRepository = LocalRepository();

    RemoteRepository remoteRepository = RemoteRepository();

    //Init the InstanceProvider with our repositories, crash and analytics reporters.
    //The sdk will need them even if they are empty. For example functionality in the SDK
    //may auto log data in the analytics. Currently we send the BaseAnalyticsUtil, which is
    //an empty implementation, but one day can have our own class that will implement this one
    //and start logging analytics events to some server.
    InstanceProvider.init(remoteRepository, localRepository, BaseCrashReporter(), BaseAnalyticsUtil());

    //Here is an example how to log an event to our analytics reporter, which for now has empty implementation.
    //For example on each opened screen, if the state is extending from BaseState, then open screen
    //event will be auto logged with its tag name.
    InstanceProvider.getInstance()?.analyticsUtil?.logAppOpen();

    //Here is an example how to add data to our crash reporter, which will be sent with the crash.
    //Currently is an empty implementation.
    InstanceProvider.getInstance()?.crashReporter?.setDevice();

    await _initLanguage();
  }

  ///We first get the device's locale and try to find a strings set that matches this language.
  ///Ones we have the AppLocale then init our localization class with it.
  Future _initLanguage() async {
    // If you want to test manually app locale without changing the device language, uncomment bellow line.
    // return await _setLocale(EnUSStrings());

    AppLocale defaultLanguageEn = EnUSStrings();

    //For now we support only one language
    List<AppLocale> supportedAppLocales = [
      defaultLanguageEn,
      //other language sets....
    ];

    AppLocale deviceLocale = await Localization.findDeviceLocale(supportedAppLocales, defaultLanguageEn);

    //There is an option to set all supported locales and current locale, the switch the locales with
    // Localization.setLocale function, but is more optimal to re-init the Localization and hold in the
    //memory only one language map.
    _setLocale(deviceLocale, [deviceLocale]);
  }

  Future _setLocale(AppLocale locale, List<AppLocale> supportedAppLocales) async {
    //This will set the locale in polarSdk and load correct translations in the app
    Localization.init(null, supportedAppLocales, locale);
    //This will set the locale for system widgets
    Intl.defaultLocale = locale.languageCode;
    //This initialization is important to make sure all dates are parsed in this locale
    await initializeDateFormatting(locale.languageCode, null);
  }
}
