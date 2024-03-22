import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/models/local/post/comment_hive_model.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_info_hive_model.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';
import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  LocalStorage._();
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserInfoHiveModelAdapter());
    Hive.registerAdapter(UserHiveModelAdapter());
    Hive.registerAdapter(PostHiveModelAdapter());
    Hive.registerAdapter(CommentHiveModelAdapter());
    Hive.registerAdapter(ForumHiveModelAdapter());
    Hive.registerAdapter(TopicHiveModelAdapter());

    await Hive.openBox<UserHiveModel>(AppBoxesName.userBox);
    await Hive.openBox<PostHiveModel>(AppBoxesName.postBox);
    await Hive.openBox<CommentHiveModel>(AppBoxesName.commentBox);
    await Hive.openBox<ForumHiveModel>(AppBoxesName.forumBox);
    await Hive.openBox<TopicHiveModel>(AppBoxesName.topicBox);
  }
}
