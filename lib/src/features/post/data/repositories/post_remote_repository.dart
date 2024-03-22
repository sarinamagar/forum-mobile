import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/mappers/remote/post_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/features/post/data/datasources/remote/post_datasource.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class PostRemoteRepository implements PostRepository {
  final PostDataSource postDataSource;

  PostRemoteRepository({required this.postDataSource});
  @override
  Future<Either<Failure, Post>> getPost(String postId) async {
    try {
      final PostApiModel postApiModel = await postDataSource.getPost(postId);
      return Right(postApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> getCommentById(String commentID) async {
    try {
      final CommentApiModel commentApiModel =
          await postDataSource.getCommentById(commentID);
      return Right(commentApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Post>> addPost(AddPostRequestDto dto) async {
    try {
      final PostApiModel postApiModel = await postDataSource.addPost(dto);
      return Right(postApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> addComment(AddCommentRequestDto dto) async {
    try {
      final CommentApiModel commentApiModel =
          await postDataSource.addComment(dto);
      return Right(commentApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Comment>> addReply(AddReplyRequestDto dto) async {
    try {
      final CommentApiModel commentApiModel =
          await postDataSource.addReply(dto);
      return Right(commentApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> downvotePost(AddVoteRequestDto dto) async {
    try {
      postDataSource.downvotePost(dto);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> upvotePost(AddVoteRequestDto dto) async {
    try {
      bool hasUpVoted = await postDataSource.upvotePost(dto);
      return Right(hasUpVoted);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> upvoteComment(CommentVoteRequestDto dto) async {
    try {
      bool hasUpVoted = await postDataSource.upvoteComment(dto);
      return Right(hasUpVoted);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> downvoteComment(
      CommentVoteRequestDto dto) async {
    try {
      postDataSource.downvoteComment(dto);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
