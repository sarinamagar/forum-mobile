import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/mappers/local/forum_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/forum_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/post_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/network/connectivity_checker.dart';
import 'package:forum/src/features/forum/data/datasources/local/forum_local_datasource.dart';
import 'package:forum/src/features/forum/data/datasources/remote/forum_datasource.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/models/remote/forum_api_model.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';

class ForumRemoteRepository implements ForumRepository {
  final ForumDataSource forumDataSource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;
  final ForumLocalDataSource forumLocalDataSource;
  ForumRemoteRepository({
    required this.forumDataSource,
    required this.checkInternetConnectivity,
    required this.forumLocalDataSource,
  });
  @override
  Future<Either<Failure, List<Forum>>> loadUserForums(String userID) async {
    try {
      List<ForumApiModel> forumsModel =
          await forumDataSource.loadUserForums(userID);
      List<Forum> forums =
          forumsModel.map((forum) => forum.toDomain()).toList();
      return Right(forums);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Forum>>> loadJoinedForums(String userID) async {
    try {
      List<ForumApiModel> forumsModel =
          await forumDataSource.loadJoinedForums(userID);
      List<Forum> forums =
          forumsModel.map((forum) => forum.toDomain()).toList();
      return Right(forums);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Forum>>> loadForums() async {
    if (await checkInternetConnectivity.isConnected()) {
      try {
        List<ForumApiModel> forumsModel = await forumDataSource.loadForums();
        List<Forum> forums =
            forumsModel.map((forum) => forum.toDomain()).toList();
        return Right(forums);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      final forums = forumLocalDataSource.loadForums();
      return Right(forums.map((e) => e.toApi().toDomain()).toList());
    }
  }

  @override
  Future<Either<Failure, List<Forum>>> topicForums(String topicID) async {
    try {
      List<ForumApiModel> forumsModel =
          await forumDataSource.topicForums(topicID);
      List<Forum> forums =
          forumsModel.map((forum) => forum.toDomain()).toList();
      return Right(forums);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> forumPosts(String forumID) async {
    try {
      List<PostApiModel> postsModel = await forumDataSource.forumPosts(forumID);
      List<Post> posts = postsModel.map((post) => post.toDomain()).toList();
      return Right(posts);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Forum>> createForum(CreateForumRequestDto dto) async {
    try {
      final ForumApiModel forumApiModel =
          await forumDataSource.createForum(dto);
      return Right(forumApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Forum>> joinForum(JoinForumRequestDto dto) async {
    try {
      final ForumApiModel forumApiModel = await forumDataSource.joinForum(dto);
      return Right(forumApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
