import 'package:forum/src/core/models/local/post/comment_hive_model.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';
import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppBoxesName {
  AppBoxesName._();
  static const String userBox = 'userBox';
  static const String postBox = 'postBox';
  static const String commentBox = 'commentBox';
  static const String forumBox = 'forumBox';
  static const String topicBox = 'topicBox';
}

class AppBoxes {
  AppBoxes._();
  static Box<UserHiveModel> get userBox =>
      Hive.box<UserHiveModel>(AppBoxesName.userBox);
  static Box<PostHiveModel> get postBox =>
      Hive.box<PostHiveModel>(AppBoxesName.postBox);
  static Box<CommentHiveModel> get commentBox =>
      Hive.box<CommentHiveModel>(AppBoxesName.commentBox);
  static Box<ForumHiveModel> get forumBox =>
      Hive.box<ForumHiveModel>(AppBoxesName.forumBox);
  static Box<TopicHiveModel> get topicBox =>
      Hive.box<TopicHiveModel>(AppBoxesName.topicBox);
}

class AppBoxesKeys {
  AppBoxesKeys._();
  static const String user = 'user';
  static const String post = 'post';
  static const String comment = 'comment';
  static const String forum = 'forum';
  static const String topic = 'topic';
}
