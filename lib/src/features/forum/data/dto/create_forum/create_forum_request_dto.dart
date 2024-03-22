import 'dart:io';

import 'package:forum/src/core/functions/file_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_forum_request_dto.g.dart';

@JsonSerializable()
class CreateForumRequestDto {
  final String forumName;
  final String description;
  final String createdBy;
  final String? topics;
  final bool isNSFW;
  @FileConverter()
  File? icon;
  @FileConverter()
  File? cover;

  CreateForumRequestDto({
    required this.forumName,
    required this.description,
    required this.createdBy,
    this.topics,
    required this.isNSFW,
    this.icon,
    this.cover,
  });

  factory CreateForumRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateForumRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateForumRequestDtoToJson(this);
}
