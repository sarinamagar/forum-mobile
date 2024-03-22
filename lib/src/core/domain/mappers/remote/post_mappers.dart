import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/forum_mappers.dart';
import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';

extension PostExtension on Post {
  PostApiModel fromDomain() => PostApiModel(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.fromDomain(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.fromDomain(),
        comments: comments?.map((e) => e.fromDomain()).toList(),
        upvotes: upvotes?.map((e) => e.fromDomain()).toList(),
        downvotes: downvotes?.map((e) => e.fromDomain()).toList(),
      );
}

extension PostApiModelExtension on PostApiModel {
  Post toDomain() => Post(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.toDomain(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.toDomain(),
        comments: comments?.map((e) => e.toDomain()).toList(),
        upvotes: upvotes?.map((e) => e.toDomain()).toList(),
        downvotes: downvotes?.map((e) => e.toDomain()).toList(),
      );
}

extension CommentExtension on Comment {
  CommentApiModel fromDomain() => CommentApiModel(
        id: id,
        commentText: commentText,
        userID: userID.fromDomain(),
        upvotes: upvotes?.map((e) => e.fromDomain()).toList(),
        downvotes: downvotes?.map((e) => e.fromDomain()).toList(),
        replies: replies?.map((e) => e.fromDomain()).toList(),
        createdAt: createdAt,
      );
}

extension CommentApiModelExtension on CommentApiModel {
  Comment toDomain() => Comment(
        id: id,
        commentText: commentText,
        userID: userID.toDomain(),
        upvotes: upvotes?.map((e) => e.toDomain()).toList(),
        downvotes: downvotes?.map((e) => e.toDomain()).toList(),
        replies: replies?.map((e) => e.toDomain()).toList(),
        createdAt: createdAt,
      );
}
