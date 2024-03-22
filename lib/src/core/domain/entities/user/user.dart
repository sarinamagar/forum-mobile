import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/user/user_info.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';

class User extends Equatable {
  final UserInfo userInfo;
  final int karma;
  final int? followers;
  final int? following;
  final List<Forum>? forums;

  const User({
    required this.userInfo,
    this.karma = 0,
    this.followers = 0,
    this.following = 0,
    this.forums,
  });

  @override
  List<Object?> get props => [userInfo, karma, followers, followers];

  User copyWith({
    UserInfo? userInfo,
    int? karma,
    int? followers,
    int? following,
    List<Forum>? forums,
  }) {
    return User(
      userInfo: userInfo ?? this.userInfo,
      karma: karma ?? this.karma, 
      followers: followers ?? this.followers,
      following: following ?? this.following,
      forums: forums ?? this.forums,
    );
  }
}
