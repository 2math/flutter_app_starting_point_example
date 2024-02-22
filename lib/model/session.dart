import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

///flutter pub run build_runner watch --delete-conflicting-outputs
///flutter pub run build_runner build --delete-conflicting-outputs

///This is a login response from the server.
@JsonSerializable(explicitToJson: true)
class Session {
  String name;
  String  email;
  String?  token;
  int id;

  Session({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
  });


  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  String toString() {
    return 'Session{name: $name, email: $email, token: $token, id: $id}';
  }
}
