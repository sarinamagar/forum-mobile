// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_forum_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateForumRequestDto _$CreateForumRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateForumRequestDto(
      forumName: json['forumName'] as String,
      description: json['description'] as String,
      createdBy: json['createdBy'] as String,
      topics: json['topics'] as String?,
      isNSFW: json['isNSFW'] as bool,
      icon: const FileConverter().fromJson(json['icon'] as String?),
      cover: const FileConverter().fromJson(json['cover'] as String?),
    );

Map<String, dynamic> _$CreateForumRequestDtoToJson(
        CreateForumRequestDto instance) =>
    <String, dynamic>{
      'forumName': instance.forumName,
      'description': instance.description,
      'createdBy': instance.createdBy,
      'topics': instance.topics,
      'isNSFW': instance.isNSFW,
      'icon': const FileConverter().toJson(instance.icon),
      'cover': const FileConverter().toJson(instance.cover),
    };
