// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_acc_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyAccResponseDto _$VerifyAccResponseDtoFromJson(
        Map<String, dynamic> json) =>
    VerifyAccResponseDto(
      message: json['message'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$VerifyAccResponseDtoToJson(
        VerifyAccResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'verified': instance.verified,
    };
