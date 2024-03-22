part of '../viewmodels/forum_viewmodel.dart';

sealed class ForumEvent extends Equatable {
  const ForumEvent();

  @override
  List<Object> get props => [];
}

class LoadForums extends ForumEvent {}

class LoadJoinedForum extends ForumEvent {
  final String userID;
  const LoadJoinedForum({
    required this.userID,
  });
}

class TopicForums extends ForumEvent {
  final String topicID;

  const TopicForums({required this.topicID});
}

class ForumLoadPosts extends ForumEvent {
  final String forumID;

  const ForumLoadPosts({required this.forumID});
}

class CreateForum extends ForumEvent {
  final CreateForumRequestDto dto;

  const CreateForum({required this.dto});
}

class JoinForum extends ForumEvent {
  final JoinForumRequestDto dto;

  const JoinForum({required this.dto});
}
