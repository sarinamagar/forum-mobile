import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sign_in_response_dto.g.dart';

@JsonSerializable()
class SignInResponseDto {
  final bool success;
  final String message;
  final UserApiModel user;
  final String token;

  SignInResponseDto({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory SignInResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);
}
