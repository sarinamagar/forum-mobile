// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadPostResponseDto _$LoadPostResponseDtoFromJson(Map<String, dynamic> json) =>
    LoadPostResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PostApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoadPostResponseDtoToJson(
        LoadPostResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
