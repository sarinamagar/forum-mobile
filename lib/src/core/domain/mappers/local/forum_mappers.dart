import 'package:forum/src/core/domain/mappers/local/post_mappers.dart';
import 'package:forum/src/core/domain/mappers/local/user_mappers.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';
import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';

extension ForumExtension on Forum {
  ForumHiveModel fromHiveDomain() => ForumHiveModel(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.fromUserDomain(),
        members: members?.map((e) => e.fromUserDomain()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.fromHiveDomain()).toList(),
        createdAt: createdAt,
      );
}

extension ForumHiveModelExtension on ForumHiveModel {
  Forum toHiveDomain() => Forum(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.toUserDomain(),
        members: members?.map((e) => e.toUserDomain()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.toHiveDomain()).toList(),
        createdAt: createdAt,
      );
}

extension TopicExtension on Topic {
  TopicHiveModel fromHiveDomain() => TopicHiveModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}

extension TopicHiveModelExtension on TopicHiveModel {
  Topic toHiveDomain() => Topic(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}

extension ForumHiveExtension on ForumHiveModel {
  ForumApiModel toApi() => ForumApiModel(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.toApi(),
        members: members?.map((e) => e.toApi()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.toApi()).toList(),
        createdAt: createdAt,
      );
}

extension ForumApiExtension on ForumApiModel {
  ForumHiveModel fromApi() => ForumHiveModel(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.fromApi(),
        members: members?.map((e) => e.fromApi()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.fromApi()).toList(),
        createdAt: createdAt,
      );
}

extension TopicApiExtension on TopicApiModel {
  TopicHiveModel fromApi() => TopicHiveModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}

extension TopicHiveExtension on TopicHiveModel {
  TopicApiModel toApi() => TopicApiModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}
