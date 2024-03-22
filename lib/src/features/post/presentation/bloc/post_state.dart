part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class PostLoading extends PostState {
  const PostLoading();
}

class PostLoadingSuccess extends PostState {
  final Post post;
  const PostLoadingSuccess({required this.post});
}

class PostLoadingFailed extends PostState {
  final String message;
  const PostLoadingFailed(this.message);
}

class PostUploading extends PostState {
  const PostUploading();
}

class PostUploadingSuccess extends PostState {
  final Post post;
  const PostUploadingSuccess({required this.post});
}

class PostUploadingFailed extends PostState {
  final String message;
  const PostUploadingFailed(this.message);
}

class CommentLoading extends PostState {
  const CommentLoading();
}

class CommentLoadingSuccess extends PostState {
  final Comment comment;
  const CommentLoadingSuccess({required this.comment});
}

class CommentLoadingFailed extends PostState {
  final String message;
  const CommentLoadingFailed(this.message);
}

class PostAddingComment extends PostState {
  const PostAddingComment();
}

class PostCommentedSuccess extends PostState {
  final Comment comment;
  const PostCommentedSuccess(this.comment);
}

class PostCommentedFailed extends PostState {
  final String message;
  const PostCommentedFailed(this.message);
}

class CommentAddingReply extends PostState {
  const CommentAddingReply();
}

class CommentRepliedSuccess extends PostState {
  final Comment comment;
  const CommentRepliedSuccess(this.comment);
}

class CommentRepliedFailed extends PostState {
  final String message;
  const CommentRepliedFailed(this.message);
}

class UpvotingPost extends PostState {
  final String postId;

  const UpvotingPost(this.postId);
}

class UpvotePostFailed extends PostState {
  final String message;
  const UpvotePostFailed(this.message);
}

class UpvotePostSuccess extends PostState {
  final bool hasVoted;

  UpvotePostSuccess({required this.hasVoted});
}

class DownvotingPost extends PostState {
  final String postId;

  const DownvotingPost(this.postId);
}

class DownvotePostFailed extends PostState {
  final String message;
  const DownvotePostFailed(this.message);
}

class DownvotePostSuccess extends PostState {}

class UpvotingComment extends PostState {
  final String commentId;

  const UpvotingComment(this.commentId);
}

class UpvoteCommentFailed extends PostState {
  final String message;
  const UpvoteCommentFailed(this.message);
}

class UpvoteCommentSuccess extends PostState {
  final bool hasVoted;

  UpvoteCommentSuccess({required this.hasVoted});
}

class DownvotingComment extends PostState {
  final String commentId;

  const DownvotingComment(this.commentId);
}

class DownvoteCommentFailed extends PostState {
  final String message;
  const DownvoteCommentFailed(this.message);
}

class DownvoteCommentSuccess extends PostState {}
