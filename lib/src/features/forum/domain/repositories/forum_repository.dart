import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';

abstract class ForumRepository {
  Future<Either<Failure, List<Forum>>> loadUserForums(String userID);
  Future<Either<Failure, List<Forum>>> loadJoinedForums(String userID);
  Future<Either<Failure, List<Forum>>> loadForums();
  Future<Either<Failure, List<Forum>>> topicForums(String topicID);
  Future<Either<Failure, List<Post>>> forumPosts(String forumID);
  Future<Either<Failure, Forum>> createForum(CreateForumRequestDto dto);
  Future<Either<Failure, Forum>> joinForum(JoinForumRequestDto dto);
}
