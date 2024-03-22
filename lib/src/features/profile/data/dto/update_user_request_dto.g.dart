// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserRequestDto _$UpdateUserRequestDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateUserRequestDto(
      userID: json['userID'] as String,
      gender: json['gender'] as String?,
      bio: json['bio'] as String?,
      avatar: const FileConverter().fromJson(json['avatar'] as String?),
    );

Map<String, dynamic> _$UpdateUserRequestDtoToJson(
        UpdateUserRequestDto instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'gender': instance.gender,
      'bio': instance.bio,
      'avatar': const FileConverter().toJson(instance.avatar),
    };
