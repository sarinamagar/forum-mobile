// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_vote_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentVoteRequestDto _$CommentVoteRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CommentVoteRequestDto(
      userID: json['userID'] as String,
      commentID: json['commentID'] as String,
    );

Map<String, dynamic> _$CommentVoteRequestDtoToJson(
        CommentVoteRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'commentID': instance.commentID,
    };
