import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/mappers/local/user_mappers.dart';
import 'package:forum/src/core/models/local/post/comment_hive_model.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/domain/mappers/local/forum_mappers.dart';

extension PostHiveModelExtension on PostHiveModel {
  Post toHiveDomain() => Post(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.toUserDomain(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.toHiveDomain(),
        comments: comments?.map((e) => e.toHiveDomain()).toList(),
        upvotes: upvotes?.map((e) => e.toUserDomain()).toList(),
        downvotes: downvotes?.map((e) => e.toUserDomain()).toList(),
      );
}

extension PostExtension on Post {
  PostHiveModel fromHiveDomain() => PostHiveModel(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.fromUserDomain(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.fromHiveDomain(),
        comments: comments?.map((e) => e.fromHiveDomain()).toList(),
        upvotes: upvotes?.map((e) => e.fromUserDomain()).toList(),
        downvotes: downvotes?.map((e) => e.fromUserDomain()).toList(),
      );
}

extension CommentExtension on Comment {
  CommentHiveModel fromHiveDomain() => CommentHiveModel(
        id: id,
        commentText: commentText,
        userID: userID.fromUserDomain(),
        upvotes: upvotes?.map((e) => e.fromUserDomain()).toList(),
        downvotes: downvotes?.map((e) => e.fromUserDomain()).toList(),
        replies: replies?.map((e) => e.fromHiveDomain()).toList(),
        createdAt: createdAt,
      );
}

extension CommentHiveModelExtension on CommentHiveModel {
  Comment toHiveDomain() => Comment(
        id: id,
        commentText: commentText,
        userID: userID.toUserDomain(),
        upvotes: upvotes?.map((e) => e.toUserDomain()).toList(),
        downvotes: downvotes?.map((e) => e.toUserDomain()).toList(),
        replies: replies?.map((e) => e.toHiveDomain()).toList(),
        createdAt: createdAt,
      );
}

extension PostApiExtension on PostApiModel {
  PostHiveModel fromApi() => PostHiveModel(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.fromApi(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.fromApi(),
        comments: comments?.map((e) => e.fromApi()).toList(),
        upvotes: upvotes?.map((e) => e.fromApi()).toList(),
        downvotes: downvotes?.map((e) => e.fromApi()).toList(),
      );
}

extension PostHiveExtension on PostHiveModel {
  PostApiModel toApi() => PostApiModel(
        id: id,
        caption: caption,
        description: description,
        postMediaUrl: postMediaUrl,
        postLink: postLink,
        publisher: publisher.toApi(),
        isNSFW: isNSFW,
        shares: shares,
        postDate: postDate,
        forumID: forumID?.toApi(),
        comments: comments?.map((e) => e.toApi()).toList(),
        upvotes: upvotes?.map((e) => e.toApi()).toList(),
        downvotes: downvotes?.map((e) => e.toApi()).toList(),
      );
}

extension CommentApiExtension on CommentApiModel {
  CommentHiveModel fromApi() => CommentHiveModel(
        id: id,
        commentText: commentText,
        userID: userID.fromApi(),
        upvotes: upvotes?.map((e) => e.fromApi()).toList(),
        downvotes: downvotes?.map((e) => e.fromApi()).toList(),
        replies: replies?.map((e) => e.fromApi()).toList(),
        createdAt: createdAt,
      );
}

extension CommentHiveExtension on CommentHiveModel {
  CommentApiModel toApi() => CommentApiModel(
        id: id,
        commentText: commentText,
        userID: userID.toApi(),
        upvotes: upvotes?.map((e) => e.toApi()).toList(),
        downvotes: downvotes?.map((e) => e.toApi()).toList(),
        replies: replies?.map((e) => e.toApi()).toList(),
        createdAt: createdAt,
      );
}
