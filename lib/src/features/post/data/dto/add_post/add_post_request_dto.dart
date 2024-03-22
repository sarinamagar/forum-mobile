import 'dart:io';

import 'package:forum/src/core/functions/file_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_post_request_dto.g.dart';

@JsonSerializable()
class AddPostRequestDto {
  String caption;
  String? description;
  String? postLink;
  String publisher;
  String? forumID;

  @FileConverter()
  File? media;

  bool? isNSFW;

  AddPostRequestDto({
    required this.caption,
    this.description,
    this.postLink,
    required this.publisher,
    this.forumID,
    this.media,
    this.isNSFW = false,
  });

  factory AddPostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddPostRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddPostRequestDtoToJson(this);
}
