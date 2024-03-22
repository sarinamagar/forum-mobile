import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/entities/user/user_info.dart';
import 'package:forum/src/core/domain/mappers/remote/forum_mappers.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_info_api_model.dart';

extension UserInfoApiModelExtension on UserInfoApiModel {
  UserInfo toDomain() => UserInfo(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
        createdAt: createdAt,
      );
}

extension UserInfoExtension on UserInfo {
  UserInfoApiModel fromDomain() => UserInfoApiModel(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
        createdAt: createdAt,
      );
}

extension UserApiModelExtension on UserApiModel {
  User toDomain() => User(
        userInfo: userInfo.toDomain(),
        karma: karma,
        followers: followers,
        following: following,
        forums: forums?.map((e) => e.toDomain()).toList(),
      );
}

extension UserExtension on User {
  UserApiModel fromDomain() => UserApiModel(
        userInfo: userInfo.fromDomain(),
        karma: karma,
        followers: followers,
        following: following,
        forums: forums?.map((e) => e.fromDomain()).toList(),
      );
}
