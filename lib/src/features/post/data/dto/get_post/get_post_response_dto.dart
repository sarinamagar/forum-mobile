import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_post_response_dto.g.dart';

@JsonSerializable()
class GetPostResponseDto {
  final bool success;
  final String message;
  final PostApiModel data;

  GetPostResponseDto({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetPostResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetPostResponseDtoFromJson(json);

    Map<String, dynamic> toJson() => _$GetPostResponseDtoToJson(this);
}
