import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response_dto.g.dart';

@JsonSerializable()
class SignUpResponseDto {
  final bool success;
  final String message;
  final UserApiModel data;

  SignUpResponseDto(
      {required this.success, required this.message, required this.data});

  factory SignUpResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseDtoToJson(this);
}
