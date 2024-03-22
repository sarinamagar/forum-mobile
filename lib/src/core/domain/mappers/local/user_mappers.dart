import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/entities/user/user_info.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_info_hive_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_info_api_model.dart';

extension UserInfoHiveModelExtension on UserInfoHiveModel {
  UserInfo toUserDomain() => UserInfo(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
      );
}

extension UserInfoExtension on UserInfo {
  UserInfoHiveModel fromDomain() => UserInfoHiveModel(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
      );
}

extension UserHiveModelExtension on UserHiveModel {
  User toUserDomain() => User(
        userInfo: userInfo.toUserDomain(),
        karma: karma,
        followers: followers,
        following: following,
      );
}

extension UserExtension on User {
  UserHiveModel fromUserDomain() => UserHiveModel(
        userInfo: userInfo.fromDomain(),
        karma: karma,
        followers: followers,
        following: following,
      );
}

extension UserInfoApiExtension on UserInfoApiModel {
  UserInfoHiveModel fromApi() => UserInfoHiveModel(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
      );
}

extension UserInfoHiveExtension on UserInfoHiveModel {
  UserInfoApiModel toApi() => UserInfoApiModel(
        uid: uid,
        username: username,
        email: email,
        password: password,
        bio: bio,
        gender: gender,
        avatarUrl: avatarUrl,
        status: status,
        verified: verified,
      );
}

extension UserApiExtension on UserApiModel {
  UserHiveModel fromApi() => UserHiveModel(
        userInfo: userInfo.fromApi(),
        karma: karma,
        followers: followers,
        following: following,
      );
}

extension UserHiveExtension on UserHiveModel {
  UserApiModel toApi() => UserApiModel(
        userInfo: userInfo.toApi(),
        karma: karma,
        followers: followers,
        following: following,
      );
}
