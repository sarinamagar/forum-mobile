import 'dart:io';

import 'package:forum/src/core/functions/file_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_request_dto.g.dart';

@JsonSerializable()
class UpdateUserRequestDto {
  final String userID;
  final String? gender;
  final String? bio;
  @FileConverter()
  final File? avatar;

  UpdateUserRequestDto(
      {required this.userID, this.gender, this.bio, this.avatar});

  factory UpdateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRequestDtoToJson(this);
}
