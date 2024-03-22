import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/hive_table.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'comment_hive_model.g.dart';

@HiveType(typeId: HiveTable.commentTableId)
class CommentHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String commentText;
  @HiveField(2)
  final UserHiveModel userID;
  @HiveField(3)
  final List<UserHiveModel>? upvotes;
  @HiveField(4)
  final List<UserHiveModel>? downvotes;
  @HiveField(5)
  final List<CommentHiveModel>? replies;
  @HiveField(6)
  final String? createdAt;

  CommentHiveModel({
    required this.id,
    required this.commentText,
    required this.userID,
    required this.upvotes,
    required this.downvotes,
    required this.replies,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [commentText];
}
