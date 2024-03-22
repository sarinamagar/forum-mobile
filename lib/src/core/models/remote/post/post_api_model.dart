import 'package:equatable/equatable.dart';
import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PostApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String caption;
  final String? description;
  final String? postMediaUrl;
  final String? postLink;
  final UserApiModel publisher;
  final bool isNSFW;
  final int shares;
  final ForumApiModel? forumID;
  final List<CommentApiModel>? comments;
  final List<UserApiModel>? upvotes;
  final List<UserApiModel>? downvotes;
  @JsonKey(name: 'createdAt')
  final String postDate;

  const PostApiModel({
    this.id,
    required this.caption,
    required this.publisher,
    required this.postDate,
    this.description,
    this.postMediaUrl,
    this.postLink,
    this.isNSFW = false,
    this.shares = 0,
    this.forumID,
    this.comments,
    this.upvotes,
    this.downvotes,
  });

  @override
  List<Object?> get props => [caption, publisher, postDate];

  factory PostApiModel.fromJson(Map<String, dynamic> json) {
    return PostApiModel(
      id: json['_id'] ?? "",
      caption: json['caption'] ?? "",
      description: json['description'] ?? "",
      postMediaUrl: json['postMediaUrl'] ?? "",
      postLink: json['postLink'] ?? "",
      publisher: UserApiModel.fromJson(json['publisher'] ?? {}),
      isNSFW: json['isNSFW'] ?? false,
      shares: json['shares'] ?? 0,
      postDate: json['createdAt'] ?? "",
      forumID: ForumApiModel.fromJson(json['forumID'] ?? {}),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((comment) =>
                  CommentApiModel.fromJson(comment as Map<String, dynamic>))
              .toList() ??
          [],
      upvotes: (json['upvotes'] as List<dynamic>?)
              ?.map((upvote) =>
                  UserApiModel.fromJson(upvote as Map<String, dynamic>))
              .toList() ??
          [],
      downvotes: (json['downvotes'] as List<dynamic>?)
              ?.map((downvote) => UserApiModel.fromJson(downvote))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'description': description,
      'postMediaUrl': postMediaUrl,
      'postLink': postLink,
      'publisher': publisher.toJson(),
      'isNSFW': isNSFW,
      'shares': shares,
      'postDate': postDate,
    };
  }
}
