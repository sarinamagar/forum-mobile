part of '../viewmodels/topic_viewmodel.dart';

sealed class TopicState extends Equatable {
  const TopicState();

  @override
  List<Object> get props => [];
}

final class TopicInitial extends TopicState {}

class TopicsLoading extends TopicState {}

class TopicsLoadingSuccess extends TopicState {
  final List<Topic> topics;

  const TopicsLoadingSuccess(this.topics);

  @override
  List<Object> get props => [topics];
}

class TopicsLoadingFailed extends TopicState {
  final String message;

  const TopicsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class UserForumsLoading extends TopicState {}

class UserForumsSuccess extends TopicState {
  final List<Forum> forums;

  const UserForumsSuccess(this.forums);

  @override
  List<Object> get props => [forums];
}

class UserForumsFailed extends TopicState {
  final String message;

  const UserForumsFailed(this.message);

  @override
  List<Object> get props => [message];
}
