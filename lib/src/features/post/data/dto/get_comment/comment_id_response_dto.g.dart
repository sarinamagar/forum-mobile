// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_id_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentIdResponseDto _$CommentIdResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CommentIdResponseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: CommentApiModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentIdResponseDtoToJson(
        CommentIdResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
