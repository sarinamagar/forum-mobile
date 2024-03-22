import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';

abstract class PostRepository {
  Future<Either<Failure, Post>> getPost(String postId);
  Future<Either<Failure, Post>> addPost(AddPostRequestDto dto);
  Future<Either<Failure, Comment>> getCommentById(String commentID);
  Future<Either<Failure, Comment>> addComment(AddCommentRequestDto dto);
  Future<Either<Failure, Comment>> addReply(AddReplyRequestDto dto);
  Future<Either<Failure, bool>> upvotePost(AddVoteRequestDto dto);
  Future<Either<Failure, void>> downvotePost(AddVoteRequestDto dto);
  Future<Either<Failure, bool>> upvoteComment(CommentVoteRequestDto dto);
  Future<Either<Failure, void>> downvoteComment(CommentVoteRequestDto dto);
}
