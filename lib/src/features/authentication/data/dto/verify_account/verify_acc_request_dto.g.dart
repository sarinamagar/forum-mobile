// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_acc_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccRequestDto _$VerifyAccRequestDtoFromJson(Map<String, dynamic> json) =>
    VerifyAccRequestDto(
      email: json['email'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$VerifyAccRequestDtoToJson(
        VerifyAccRequestDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'token': instance.token,
    };
