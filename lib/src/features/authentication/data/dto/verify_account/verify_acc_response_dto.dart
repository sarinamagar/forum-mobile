import 'package:json_annotation/json_annotation.dart';

part 'verify_acc_response_dto.g.dart';

@JsonSerializable()
class VerifyAccResponseDto {
  final String message;
  final bool verified;

  VerifyAccResponseDto({required this.message, required this.verified});

  factory VerifyAccResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VerifyAccResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyAccResponseDtoToJson(this);
}