import 'package:equatable/equatable.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ForumApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? forumName;
  final String? iconUrl;
  final String? coverUrl;
  final String? description;
  final UserApiModel? createdBy;
  final List<UserApiModel>? members;
  final List<String>? rules;
  final bool? isNSFW;
  final List<String>? tags;
  final List<PostApiModel>? posts;
  final String? createdAt;

  const ForumApiModel({
    this.id,
    this.forumName,
    this.iconUrl,
    this.coverUrl,
    this.description,
    this.createdBy,
    this.members,
    this.rules,
    this.isNSFW = false,
    this.tags,
    this.posts,
    this.createdAt,
  });

  @override
  List<Object?> get props => [forumName, createdBy, createdAt];

  factory ForumApiModel.fromJson(Map<String, dynamic> json) {
    return ForumApiModel(
      id: json['_id'],
      forumName: json['forumName'],
      iconUrl: json['iconUrl'],
      coverUrl: json['coverUrl'],
      description: json['description'] ?? "",
      createdBy: UserApiModel.fromJson(json['createdBy'] ?? {}),
      members: (json['members'] as List<dynamic>?)
          ?.map((members) =>
              UserApiModel.fromJson(members as Map<String, dynamic>))
          .toList(),
      rules: (json['rules'] as List<dynamic>?)
          ?.map((rule) => rule as String)
          .toList(),
      isNSFW: json['isNSFW'],
      tags: (json['tags'] as List<dynamic>?)
          ?.map((tag) => tag as String)
          .toList(),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((post) => PostApiModel.fromJson(post as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'],
    );
  }
}
