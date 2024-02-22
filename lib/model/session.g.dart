// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      name: json['name'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
      id: json['id'] as int,
    );

Map<String, dynamic> _$SessionToJson(Session instance) =>
    <String, dynamic>{'name': instance.name, 'email': instance.email, 'id': instance.id, 'token': instance.token};
