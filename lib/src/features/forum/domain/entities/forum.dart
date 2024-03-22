import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';

class Forum extends Equatable {
  final String? id;
  final String? forumName;
  final String? iconUrl;
  final String? coverUrl;
  final String? description;
  final User? createdBy;
  final List<User>? members;
  final List<String>? rules;
  final bool? isNSFW;
  final List<String>? tags;
  final List<Post>? posts;
  final String? createdAt;

  const Forum({
    this.id,
    this.forumName,
    this.iconUrl,
    this.coverUrl,
    this.description,
    this.createdBy,
    this.members,
    this.rules,
    this.isNSFW = false,
    this.tags,
    this.posts,
    this.createdAt,
  });

  @override
  List<Object?> get props => [forumName, createdBy, createdAt];
}
