import 'package:json_annotation/json_annotation.dart';

part 'comment_vote_request_dto.g.dart';

@JsonSerializable()
class CommentVoteRequestDto {
  final String userID;
  final String commentID;

  CommentVoteRequestDto({required this.userID, required this.commentID});

  factory CommentVoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CommentVoteRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentVoteRequestDtoToJson(this);
}
