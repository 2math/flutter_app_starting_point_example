import 'package:flutter/foundation.dart';

class UserCredentials {
  String? email;
  String? password;

  UserCredentials({this.email, this.password});

  @override
  String toString() {
    return 'UserCredentials{'
        //Show sensitive information only in debug mode
        'email: $email, password: ${kDebugMode ? password : '***'}';
  }
}
