import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response_dto.g.dart';

@JsonSerializable()
class ResetPasswordResponseDto {
  final String message;
  final UserApiModel user;

  factory ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseDtoFromJson(json);

  ResetPasswordResponseDto({required this.message, required this.user});

  Map<String, dynamic> toJson() => _$ResetPasswordResponseDtoToJson(this);
}
