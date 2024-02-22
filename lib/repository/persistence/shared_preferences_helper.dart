import 'dart:async';
import 'dart:collection';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../model/user_credentials.dart';

class SharedPreferencesHelper {
  static const String _session = "_session";
  static const String _email = "_email";
  static const String _pass = "_pass";
  static SharedPreferencesHelper? _instance;

  ///init static prefs
  static Future<SharedPreferences?> init() async {
    _instance ??= SharedPreferencesHelper();
    _instance!._sharedPreferences ??= await SharedPreferences.getInstance();
    return _instance!._sharedPreferences;
  }

  SharedPreferences? _sharedPreferences;
  FlutterSecureStorage? _secureStorage;

  SharedPreferencesHelper() {
    _secureStorage = const FlutterSecureStorage();
  }

  Future refresh() async {
    await init();
    await _sharedPreferences?.reload();
  }

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
  }

  SharedPreferences? getPrefs() {
    return _sharedPreferences;
  }

  ///If value is null, current key will be deleted,
  ///else will be saved.
  setString(String key, String? value) {
    if (value == null) {
      getPrefs()?.remove(key);
    } else {
      getPrefs()?.setString(key, value);
    }
  }

  ///If value is null, current key will be deleted,
  ///else will be saved.
  setBool(String key, bool? value) {
    if (value == null) {
      getPrefs()?.remove(key);
    } else {
      getPrefs()?.setBool(key, value);
    }
  }

  ///If value is null, current key will be deleted,
  ///else will be saved.
  setInt(String key, int? value) {
    if (value == null) {
      getPrefs()?.remove(key);
    } else {
      getPrefs()?.setInt(key, value);
    }
  }

  ///If value is null, current key will be deleted,
  ///else will be saved.
  setDouble(String key, double? value) {
    if (value == null) {
      getPrefs()?.remove(key);
    } else {
      getPrefs()?.setDouble(key, value);
    }
  }

  ///If value is null, current key will be deleted,
  ///else will be saved.
  setStringList(String key, List<String>? value) {
    if (value == null) {
      getPrefs()?.remove(key);
    } else {
      getPrefs()?.setStringList(key, value);
    }
  }

  ///Export shared preferences file as a Map.
  Map<String, dynamic> export() {
    Map<String, dynamic> map = HashMap();

    Set<String>? keys = getPrefs()?.getKeys();

    if (keys != null) {
      for (final key in keys) {
        map[key] = getPrefs()?.get(key);
      }
    }

    return map;
  }

  static SharedPreferencesHelper? getInstance() => _instance;

  saveCredentials(String? email, String? pass) {
    //save encrypted credentials
    _secureStorage?.write(key: _email, value: email);
    _secureStorage?.write(key: _pass, value: pass);
  }

  Future<UserCredentials> getCredentials() async {
    UserCredentials credentials = UserCredentials();

    credentials.email = await _secureStorage?.read(key: _email);

    if (credentials.email != null) {
      credentials.password = await _secureStorage?.read(key: _pass);
    }

    return credentials;
  }

  String? getSession() {
    return getPrefs()?.getString(_session);
  }

  saveSession(String? value) {
    setString(_session, value);
  }

  ///Call it on user logout.
  ///It deletes user's password and current session.
  ///User's username remains and next time when you open the login screen could be populated.
  logout() {
    _secureStorage?.delete(key: _pass);
    saveSession(null);
    //clear();
  }

  ///Delete all data.
  clear() {
    getPrefs()?.clear();
    _secureStorage?.deleteAll();
  }
}
