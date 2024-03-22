import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_post_response_dto.g.dart';

@JsonSerializable()
class AddPostResponseDto {
  final bool success;
  final String message;
  final PostApiModel data;

  AddPostResponseDto({
    required this.success,
    required this.message,
    required this.data,
  });

  factory AddPostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddPostResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddPostResponseDtoToJson(this);
}
