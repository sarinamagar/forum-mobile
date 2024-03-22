// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostResponseDto _$GetPostResponseDtoFromJson(Map<String, dynamic> json) =>
    GetPostResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PostApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPostResponseDtoToJson(GetPostResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
