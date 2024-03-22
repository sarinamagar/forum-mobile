// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostRequestDto _$AddPostRequestDtoFromJson(Map<String, dynamic> json) =>
    AddPostRequestDto(
      caption: json['caption'] as String,
      description: json['description'] as String?,
      postLink: json['postLink'] as String?,
      publisher: json['publisher'] as String,
      forumID: json['forumID'] as String?,
      media: const FileConverter().fromJson(json['media'] as String?),
      isNSFW: json['isNSFW'] as bool? ?? false,
    );

Map<String, dynamic> _$AddPostRequestDtoToJson(AddPostRequestDto instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'description': instance.description,
      'postLink': instance.postLink,
      'publisher': instance.publisher,
      'forumID': instance.forumID,
      'media': const FileConverter().toJson(instance.media),
      'isNSFW': instance.isNSFW,
    };
