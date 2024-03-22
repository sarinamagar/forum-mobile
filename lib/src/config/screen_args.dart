import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';

class PostScreensArgs {
  final Post post;
  final User personInfo;
  final Comment? comment;
  final Comment? reply;
  PostScreensArgs({
    required this.post,
    required this.personInfo,
    this.comment,
    this.reply,
  });

  PostScreensArgs copyWith({
    Post? post,
    User? personInfo,
    Comment? comment,
    Comment? reply,
  }) {
    return PostScreensArgs(
      post: post ?? this.post,
      personInfo: personInfo ?? this.personInfo,
      comment: comment ?? this.comment,
      reply: reply ?? this.reply,
    );
  }
}

class ForumScreensArgs {
  final Topic? topic;
  final User? userInfo;
  final Forum? forum;

  ForumScreensArgs({
    this.topic,
    this.userInfo,
    this.forum,
  });

  ForumScreensArgs copyWith({
    Topic? topic,
    User? userInfo,
    Forum? forum,
  }) {
    return ForumScreensArgs(
      topic: topic ?? this.topic,
      userInfo: userInfo ?? this.userInfo,
      forum: forum ?? this.forum,
    );
  }
}
