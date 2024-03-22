import 'package:json_annotation/json_annotation.dart';

part 'verify_acc_request_dto.g.dart';

@JsonSerializable()
class VerifyAccRequestDto {
  final String email;
  final String token;

  VerifyAccRequestDto({required this.email, required this.token});

  factory VerifyAccRequestDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAccRequestDtoToJson(this);
}
