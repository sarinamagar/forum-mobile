import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_id_response_dto.g.dart';

@JsonSerializable()
class CommentIdResponseDto {
  final bool success;
  final String message;
  final CommentApiModel data;

  CommentIdResponseDto({
    required this.success,
    required this.message,
    required this.data,
  });
  factory CommentIdResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CommentIdResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CommentIdResponseDtoToJson(this);
}
