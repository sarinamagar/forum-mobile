import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserInfoApiModel extends Equatable {
  @JsonKey(name: '_id')
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

  const UserInfoApiModel({
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
  List<Object?> get props => [uid, username, email, avatarUrl];

  factory UserInfoApiModel.fromJson(Map<String, dynamic> json) {
    return UserInfoApiModel(
      uid: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      bio: json['bio'],
      gender: json['gender'],
      avatarUrl: json['avatarUrl'],
      status: json['status'],
      verified: json['verified'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': uid,
      'username': username,
      'email': email,
      'password': password,
      'bio': bio,
      'gender': gender,
      'avatarUrl': avatarUrl,
      'status': status,
      'verified': verified,
    };
  }
}
