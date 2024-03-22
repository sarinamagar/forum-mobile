import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/hive_table.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'forum_hive_model.g.dart';

@HiveType(typeId: HiveTable.forumTableId)
class ForumHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? forumName;
  @HiveField(2)
  final String? iconUrl;
  @HiveField(3)
  final String? coverUrl;
  @HiveField(4)
  final String? description;
  @HiveField(5)
  final UserHiveModel? createdBy;
  @HiveField(6)
  final List<UserHiveModel>? members;
  @HiveField(7)
  final List<String>? rules;
  @HiveField(8)
  final bool? isNSFW;
  @HiveField(9)
  final List<String>? tags;
  @HiveField(10)
  final List<PostHiveModel>? posts;
  @HiveField(11)
  final String? createdAt;

  ForumHiveModel({
    this.id,
    this.forumName,
    this.iconUrl,
    this.coverUrl,
    this.description,
    this.createdBy,
    this.members,
    this.rules,
    this.isNSFW,
    this.tags,
    this.posts,
    this.createdAt,
  });

  @override
  List<Object?> get props => [forumName, createdBy, createdAt];
}
