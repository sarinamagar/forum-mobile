import 'package:json_annotation/json_annotation.dart';

part 'join_forum_request_dto.g.dart';

@JsonSerializable()
class JoinForumRequestDto {
  final String userID;
  final String forumID;

  JoinForumRequestDto({required this.userID, required this.forumID});

  factory JoinForumRequestDto.fromJson(Map<String, dynamic> json) =>
      _$JoinForumRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$JoinForumRequestDtoToJson(this);
}
