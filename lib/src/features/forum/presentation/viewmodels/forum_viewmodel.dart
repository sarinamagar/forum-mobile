import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/usecases/create_forum_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/forum_posts_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/join_forum_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/load_forums_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/load_joined_forums_usecase.dart';
import 'package:forum/src/features/forum/domain/usecases/topic_forums_usecase.dart';

part '../bloc/forum_event.dart';
part '../bloc/forum_state.dart';

class ForumViewModel extends Bloc<ForumEvent, ForumState> {
  final LoadJoinedForumsUsecase loadJoinedForumsUsecase;
  final LoadForumsUsecase loadForumsUsecase;
  final TopicForumsUsecase topicForumsUsecase;
  final ForumPostsUsecase forumPostsUsecase;
  final CreateForumUsecase createForumUsecase;
  final JoinForumUsecase joinForumUsecase;
  ForumViewModel({
    required this.loadJoinedForumsUsecase,
    required this.loadForumsUsecase,
    required this.topicForumsUsecase,
    required this.forumPostsUsecase,
    required this.createForumUsecase,
    required this.joinForumUsecase,
  }) : super(ForumInitial()) {
    on<ForumEvent>((event, emit) async {
      if (event is LoadJoinedForum) {
        await _loadJoinedForums(event, emit);
      }
      if (event is LoadForums) {
        await _loadForums(event, emit);
      }
      if (event is TopicForums) {
        await _topicIDForums(event, emit);
      }
      if (event is ForumLoadPosts) {
        await _forumLoadPosts(event, emit);
      }
      if (event is CreateForum) {
        await _createForum(event, emit);
      }
      if (event is JoinForum) {
        await _joinForum(event, emit);
      }
    });
  }

  List<Forum> _joinedForums = [];
  List<Forum> get joinedForums => _joinedForums;
  Future<void> _loadJoinedForums(
      LoadJoinedForum event, Emitter<ForumState> emit) async {
    emit(JoinedForumsLoading());
    final result = await loadJoinedForumsUsecase(event.userID);
    result.fold((l) => emit(JoinedForumsFailed(l.message)), (data) {
      _joinedForums = data;
      emit(JoinedForumsSuccess(data));
    });
  }

  List<Forum> _forums = [];
  List<Forum> get forums => _forums;
  Future<void> _loadForums(LoadForums event, Emitter<ForumState> emit) async {
    emit(ForumLoading());
    final result = await loadForumsUsecase(NoParams());
    result.fold((l) => emit(ForumsLoadingFailed(l.message)), (data) {
      _forums = data;
      emit(ForumsLoadingSuccess(data));
    });
  }

  List<Forum> _topicForums = [];
  List<Forum> get topicForums => _topicForums;
  Future<void> _topicIDForums(
      TopicForums event, Emitter<ForumState> emit) async {
    emit(TopicForumsLoading());
    final result = await topicForumsUsecase(event.topicID);
    result.fold((l) => emit(TopicForumsFailed(message: l.message)), (data) {
      _forums = data;
      emit(TopicForumsSuccess(forums: data));
    });
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  Future<void> _forumLoadPosts(
      ForumLoadPosts event, Emitter<ForumState> emit) async {
    emit(ForumPostsLoading());
    final result = await forumPostsUsecase(event.forumID);
    result.fold((failure) => emit(ForumPostsLoadingFailed(failure.message)),
        (data) {
      _posts = data;
      _posts.sort((a, b) {
        final aTime = DateTime.parse(a.postDate);
        final bTime = DateTime.parse(b.postDate);
        return bTime.compareTo(aTime);
      });
      emit(ForumPostsLoadingSuccess(_posts));
    });
  }

  Future<void> _createForum(CreateForum event, Emitter<ForumState> emit) async {
    emit(const CreatingForum());
    final result = await createForumUsecase(event.dto);
    result.fold(
      (failure) => emit(CreateForumFailed(failure.message)),
      (success) => emit(CreateForumSuccess(forum: success)),
    );
  }

  Future<void> _joinForum(JoinForum event, Emitter<ForumState> emit) async {
    emit(JoiningForum());
    final result = await joinForumUsecase(event.dto);
    result.fold(
      (failure) => emit(JoinForumFailed(failure.message)),
      (success) => emit(JoinForumSuccess(forum: success)),
    );
  }
}
