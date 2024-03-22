part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class UploadPost extends PostEvent {
  final AddPostRequestDto dto;

  UploadPost({required this.dto});
}

class GetPost extends PostEvent {
  final String postId;

  const GetPost({required this.postId});
}

class GetCommentById extends PostEvent {
  final String commentID;

  const GetCommentById({required this.commentID});
}

class AddComment extends PostEvent {
  final AddCommentRequestDto dto;

  const AddComment(this.dto);
}

class AddReply extends PostEvent {
  final AddReplyRequestDto dto;

  const AddReply(this.dto);
}

class UpvotePost extends PostEvent {
  final AddVoteRequestDto dto;

  const UpvotePost({required this.dto});
}

class DownvotePost extends PostEvent {
  final AddVoteRequestDto dto;

  const DownvotePost({required this.dto});
}

class UpvoteComment extends PostEvent {
  final CommentVoteRequestDto dto;

  const UpvoteComment({required this.dto});
}

class DownvoteComment extends PostEvent {
  final CommentVoteRequestDto dto;

  const DownvoteComment({required this.dto});
}
