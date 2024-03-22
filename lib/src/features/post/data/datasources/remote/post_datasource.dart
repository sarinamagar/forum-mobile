import 'package:forum/src/core/models/remote/post/comment_api_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';

abstract class PostDataSource {
  Future<PostApiModel> addPost(AddPostRequestDto dto);
  Future<PostApiModel> getPost(String postId);
  Future<CommentApiModel> getCommentById(String commentID);
  Future<CommentApiModel> addComment(AddCommentRequestDto dto);
  Future<CommentApiModel> addReply(AddReplyRequestDto dto);
  Future<bool> upvotePost(AddVoteRequestDto dto);
  Future<void> downvotePost(AddVoteRequestDto dto);
  Future<bool> upvoteComment(CommentVoteRequestDto dto);
  Future<void> downvoteComment(CommentVoteRequestDto dto);
}
