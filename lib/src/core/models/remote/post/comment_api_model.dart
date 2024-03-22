import 'package:equatable/equatable.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommentApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String commentText;
  final UserApiModel userID;
  final List<UserApiModel>? upvotes;
  final List<UserApiModel>? downvotes;
  final List<CommentApiModel>? replies;
  final String? createdAt;

  const CommentApiModel({
    this.id,
    required this.commentText,
    required this.userID,
    this.upvotes,
    this.downvotes,
    this.replies,
    this.createdAt,
  });

  @override
  List<Object?> get props => [commentText];

  factory CommentApiModel.fromJson(Map<String, dynamic> json) {
    return CommentApiModel(
      id: json['_id'],
      commentText: json['commentText'],
      userID: UserApiModel.fromJson(json['userID']),
      upvotes: (json['upvotes'] as List<dynamic>?)
          ?.where((upvote) => upvote is Map<String, dynamic>)
          ?.map(
              (upvote) => UserApiModel.fromJson(upvote as Map<String, dynamic>))
          .toList(),
      downvotes: (json['downvotes'] as List<dynamic>?)
          ?.where((upvote) => upvote is Map<String, dynamic>)
          ?.map((downvote) => UserApiModel.fromJson(downvote))
          .toList(),
      replies: (json['replies'] as List<dynamic>?)
          ?.where((reply) => reply is Map<String, dynamic>)
          ?.map((reply) => CommentApiModel.fromJson(reply))
          .toList(),
      createdAt: json['createdAt'],
    );
  }
}
