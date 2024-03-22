import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? uid;
  final String? username;
  final String? email;
  final String? password;
  final String? bio;
  final String? gender;
  final String? avatarUrl;
  final String? status;
  final bool? verified;
  final String? createdAt;

  const UserInfo({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.avatarUrl,
    this.bio,
    this.gender,
    this.status,
    this.verified,
    this.createdAt,
  });

  @override
  List<Object?> get props => [uid, username, avatarUrl];

  UserInfo copyWith({
    String? uid,
    String? username,
    String? email,
    String? password,
    String? bio,
    String? gender,
    String? avatarUrl,
    String? status,
    bool? verified,
  }) {
    return UserInfo(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      verified: verified ?? this.verified,
    );
  }
}
