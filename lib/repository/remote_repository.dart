import 'dart:convert';

import 'package:g_base_package/base/provider/instance_provider.dart';

import '../model/session.dart';
import 'local_repository.dart';
import 'net/network_manager.dart';

class RemoteRepository {

  LocalRepository? _localRepository;

  LocalRepository _getLocalRepository() {
    if (_localRepository == null) {
      _localRepository = InstanceProvider.getInstance()!.provideLocalRepository();
    }
    return _localRepository!;
  }

  ///Returns [Session] object on positive response.
  ///On positive response will store the entire session and
  ///user's credentials in encrypted storage for autologin(refresh session).
  ///It may throw [AppException] with code [AppException.OFFLINE_ERROR]
  ///if there is no network or server exception, which will be also in [AppException].
  Future<Session?> login(String email, String password) async {

    Session? session = await NetworkManager().login(email, password, (json) async {
      //Positive response so save credentials to be reused for refresh session in case is expired during usages.
      _getLocalRepository().saveCredentials(email, password);

      //Parsing the json into an object and returning it as a response
      Session session = Session.fromJson(jsonDecode(json));

      _getLocalRepository().saveSession(json, session);
      return session;
    });

    return session;
  }
}
