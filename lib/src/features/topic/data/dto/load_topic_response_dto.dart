import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'load_topic_response_dto.g.dart';

@JsonSerializable()
class LoadTopicRespnseDto {
  final bool success;
  final String message;
  final int count;
  final List<TopicApiModel> data;

  LoadTopicRespnseDto({
    required this.success,
    required this.message,
    required this.count,
    required this.data,
  });
  factory LoadTopicRespnseDto.fromJson(Map<String, dynamic> json) =>
      _$LoadTopicRespnseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoadTopicRespnseDtoToJson(this);
}
