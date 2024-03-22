part of '../viewmodels/topic_viewmodel.dart';

sealed class TopicEvent extends Equatable {
  const TopicEvent();

  @override
  List<Object> get props => [];
}

class TopicLoadTopics extends TopicEvent {}

class LoadUserForum extends TopicEvent {
  final String userID;
  const LoadUserForum({
    required this.userID,
  });
}
