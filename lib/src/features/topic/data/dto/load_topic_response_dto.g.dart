// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'load_topic_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadTopicRespnseDto _$LoadTopicRespnseDtoFromJson(Map<String, dynamic> json) =>
    LoadTopicRespnseDto(
      success: json['success'] as bool,
      message: json['message'] as String,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => TopicApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoadTopicRespnseDtoToJson(
        LoadTopicRespnseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'count': instance.count,
      'data': instance.data,
    };
