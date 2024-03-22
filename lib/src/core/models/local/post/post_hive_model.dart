import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/hive_table.dart';
import 'package:forum/src/core/models/local/post/comment_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post_hive_model.g.dart';

@HiveType(typeId: HiveTable.postTableId)
class PostHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String caption;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? postMediaUrl;
  @HiveField(4)
  final String? postLink;
  @HiveField(5)
  final UserHiveModel publisher;
  @HiveField(6)
  final bool isNSFW;
  @HiveField(7)
  final int shares;
  @HiveField(8)
  final String postDate;
  @HiveField(9)
  final List<CommentHiveModel>? comments;
  @HiveField(10)
  final List<UserHiveModel>? upvotes;
  @HiveField(11)
  final List<UserHiveModel>? downvotes;
  @HiveField(11)
  final ForumHiveModel? forumID;

  PostHiveModel({
    this.id,
    required this.caption,
    required this.publisher,
    required this.postDate,
    this.description,
    this.postMediaUrl,
    this.postLink,
    this.isNSFW = false,
    this.shares = 0,
    this.comments,
    this.upvotes,
    this.downvotes,
    this.forumID,
  });

  @override
  List<Object?> get props => [caption, publisher, postDate];
}
