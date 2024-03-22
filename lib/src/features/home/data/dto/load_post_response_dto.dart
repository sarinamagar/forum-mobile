import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'load_post_response_dto.g.dart';

@JsonSerializable()
class LoadPostResponseDto {
  final bool success;
  final String message;
  final List<PostApiModel> data;

  LoadPostResponseDto({
    required this.success,
    required this.message,
    required this.data,
  });
  factory LoadPostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoadPostResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoadPostResponseDtoToJson(this);
}
