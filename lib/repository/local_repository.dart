import 'dart:convert';

import '../model/session.dart';
import '../model/user_credentials.dart';
import 'persistence/shared_preferences_helper.dart';

///Access to local data.
///Stored data into shared preferences, DB and files.
class LocalRepository {
  ///Holding the session as instance for quick access
  Session? _session;

  Session? getSession() {
    if (_session == null) {
      String? sessionJson = SharedPreferencesHelper.getInstance()?.getSession();

      if (sessionJson != null) {
        _session = Session.fromJson(jsonDecode(sessionJson));
      }
    }

    return _session;
  }

  saveSession(String? json, Session? session) {
    _session = session;

    SharedPreferencesHelper.getInstance()?.saveSession(json);
  }

  saveCredentials(String? email, String? pass) {
    SharedPreferencesHelper.getInstance()?.saveCredentials(email, pass);
  }

  Future<UserCredentials> getCredentials() {
    return SharedPreferencesHelper.getInstance()?.getCredentials() ?? Future.value(UserCredentials());
  }

  logout() {
    SharedPreferencesHelper.getInstance()?.logout();
  }
}
