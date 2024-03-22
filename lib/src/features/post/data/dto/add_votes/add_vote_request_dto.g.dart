// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_vote_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVoteRequestDto _$AddVoteRequestDtoFromJson(Map<String, dynamic> json) =>
    AddVoteRequestDto(
      userID: json['userID'] as String,
      postID: json['postID'] as String,
    );

Map<String, dynamic> _$AddVoteRequestDtoToJson(AddVoteRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'postID': instance.postID,
    };
