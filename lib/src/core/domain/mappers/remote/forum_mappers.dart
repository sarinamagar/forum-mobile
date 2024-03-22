import 'package:forum/src/core/domain/mappers/remote/post_mappers.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';

extension ForumExtension on Forum {
  ForumApiModel fromDomain() => ForumApiModel(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.fromDomain(),
        members: members?.map((e) => e.fromDomain()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.fromDomain()).toList(),
        createdAt: createdAt,
      );
}

extension ForumApiModelExtension on ForumApiModel {
  Forum toDomain() => Forum(
        id: id,
        forumName: forumName,
        iconUrl: iconUrl,
        coverUrl: coverUrl,
        description: description,
        createdBy: createdBy?.toDomain(),
        members: members?.map((e) => e.toDomain()).toList(),
        rules: rules?.map((e) => e).toList(),
        isNSFW: isNSFW,
        tags: tags,
        posts: posts?.map((e) => e.toDomain()).toList(),
        createdAt: createdAt,
      );
}

extension TopicExtension on Topic {
  TopicApiModel fromDomain() => TopicApiModel(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}

extension TopicApiModelExtension on TopicApiModel {
  Topic toDomain() => Topic(
        id: id,
        name: name,
        createdAt: createdAt,
      );
}
