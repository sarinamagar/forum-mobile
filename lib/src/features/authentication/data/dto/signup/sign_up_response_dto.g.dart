// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpResponseDto _$SignUpResponseDtoFromJson(Map<String, dynamic> json) =>
    SignUpResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: UserApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SignUpResponseDtoToJson(SignUpResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
