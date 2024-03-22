import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';

class Post extends Equatable {
  final String? id;
  final String caption;
  final String? description;
  final String? postMediaUrl;
  final String? postLink;
  final User publisher;
  final bool isNSFW;
  final int shares;
  final Forum? forumID;
  final List<Comment>? comments;
  final List<User>? upvotes;
  final List<User>? downvotes;
  final String postDate;

  const Post({
    this.id,
    required this.caption,
    required this.publisher,
    required this.postDate,
    this.description,
    this.postMediaUrl,
    this.postLink,
    this.forumID,
    this.comments,
    this.upvotes,
    this.downvotes,
    this.isNSFW = false,
    this.shares = 0,
  });
  @override
  List<Object?> get props => [caption, publisher, postDate];
}
