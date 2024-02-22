import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:g_base_package/base/net/base_network_manager.dart';
import 'package:g_base_package/base/net/call.dart';
import '../../model/session.dart';
import 'net_constants.dart';

class NetworkManager extends BaseNetworkManager {

  /**
   * open calls
   */

  ///Pass a function which will get the JsonBody as parameter and will be called in background
  ///only if the result is positive, so the app can handle there json parsing and persisting.
  Future<Session?> login(String email, String pass, Future<Session?> Function(String) handlePositiveResultBody) async {
    Call call = Call.name(
      //We use fake server, so if this is our user will get fake response. Other way will return 404.
      email == 'mm@mm.mm' && pass == 'mmmmmmmm' ? CallMethod.GET : CallMethod.POST,
      NetConstants.SESSIONS,
      body: jsonEncode({
        'username': email,
        'password': pass,
      }),
      refreshOn401: false,
      printLogs: kDebugMode,
      printResponseHeaders: true,
    );

    return doServerCall<Session?>(call, handlePositiveResultBody);
  }
}
