// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_forum_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JoinForumRequestDto _$JoinForumRequestDtoFromJson(Map<String, dynamic> json) =>
    JoinForumRequestDto(
      userID: json['userID'] as String,
      forumID: json['forumID'] as String,
    );

Map<String, dynamic> _$JoinForumRequestDtoToJson(
        JoinForumRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'forumID': instance.forumID,
    };
