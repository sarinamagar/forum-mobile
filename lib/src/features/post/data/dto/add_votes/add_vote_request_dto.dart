import 'package:json_annotation/json_annotation.dart';

part 'add_vote_request_dto.g.dart';

@JsonSerializable()
class AddVoteRequestDto {
  final String userID;
  final String postID;

  AddVoteRequestDto({required this.userID, required this.postID});

  factory AddVoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddVoteRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddVoteRequestDtoToJson(this);
}
