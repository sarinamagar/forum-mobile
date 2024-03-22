import 'package:equatable/equatable.dart';
import 'package:forum/src/core/models/remote/user/user_info_api_model.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserApiModel extends Equatable {
  final UserInfoApiModel userInfo;
  final int karma;
  final int? followers;
  final int? following;
  final List<ForumApiModel>? forums;

  const UserApiModel({
    required this.userInfo,
    this.karma = 0,
    this.followers = 0,
    this.following = 0,
    this.forums,
  });

  @override
  List<Object?> get props => [userInfo, karma, followers, followers];

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return UserApiModel(
      userInfo: UserInfoApiModel.fromJson(json),
      karma: json['karma'] ?? 0,
      followers: (json['follower'] as List<dynamic>?)?.length ?? 0,
      following: (json['following'] as List<dynamic>?)?.length ?? 0,
      forums: (json['forums'] as List<dynamic>?)
          ?.map((forum) => ForumApiModel(id: forum['_id']))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // add followers and followings
      'userInfo': userInfo.toJson(),
      'karma': karma,
    };
  }
}
