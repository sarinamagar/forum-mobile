part of '../viewmodels/forum_viewmodel.dart';

sealed class ForumState extends Equatable {
  const ForumState();

  @override
  List<Object> get props => [];
}

final class ForumInitial extends ForumState {}

class JoinedForumsLoading extends ForumState {}

class JoinedForumsSuccess extends ForumState {
  final List<Forum> forums;

  const JoinedForumsSuccess(this.forums);

  @override
  List<Object> get props => [forums];
}

class JoinedForumsFailed extends ForumState {
  final String message;

  const JoinedForumsFailed(this.message);

  @override
  List<Object> get props => [message];
}

class ForumLoading extends ForumState {}

class ForumsLoadingFailed extends ForumState {
  final String message;

  const ForumsLoadingFailed(this.message);
}

class ForumsLoadingSuccess extends ForumState {
  final List<Forum> forums;

  const ForumsLoadingSuccess(this.forums);
}

class TopicForumsLoading extends ForumState {}

class TopicForumsSuccess extends ForumState {
  final List<Forum> forums;

  const TopicForumsSuccess({required this.forums});
}

class TopicForumsFailed extends ForumState {
  final String message;

  const TopicForumsFailed({required this.message});
}

class ForumPostsLoading extends ForumState {}

class ForumPostsLoadingSuccess extends ForumState {
  final List<Post> posts;

  const ForumPostsLoadingSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class ForumPostsLoadingFailed extends ForumState {
  final String message;

  const ForumPostsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class CreatingForum extends ForumState {
  const CreatingForum();
}

class CreateForumSuccess extends ForumState {
  final Forum forum;
  const CreateForumSuccess({required this.forum});
}

class CreateForumFailed extends ForumState {
  final String message;
  const CreateForumFailed(this.message);
}

class JoiningForum extends ForumState {}

class JoinForumSuccess extends ForumState {
  final Forum forum;
  const JoinForumSuccess({required this.forum});
}

class JoinForumFailed extends ForumState {
  final String message;
  const JoinForumFailed(this.message);
}
