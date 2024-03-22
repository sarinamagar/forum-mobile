// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordResponseDto _$ResetPasswordResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponseDto(
      message: json['message'] as String,
      user: UserApiModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResetPasswordResponseDtoToJson(
        ResetPasswordResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };
