import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/usecases/load_user_forums_usecase.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';
import 'package:forum/src/features/topic/domain/usecases/load_topics_usecase.dart';

part '../bloc/topic_event.dart';
part '../bloc/topic_state.dart';

class TopicViewModel extends Bloc<TopicEvent, TopicState> {
  final LoadTopicUsecase loadTopicUsecase;
  final LoadUserForumsUsecase loadUserForumsUsecase;
  TopicViewModel(
      {required this.loadTopicUsecase, required this.loadUserForumsUsecase})
      : super(TopicInitial()) {
    on<TopicEvent>((event, emit) async {
      if (event is TopicLoadTopics) {
        await _loadTopics(event, emit);
      }
      if (event is LoadUserForum) {
        await _loadUserForums(event, emit);
      }
    });
  }
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  Future<void> _loadTopics(
      TopicLoadTopics event, Emitter<TopicState> emit) async {
    emit(TopicsLoading());
    final result = await loadTopicUsecase(NoParams());
    result.fold((failure) => emit(TopicsLoadingFailed(failure.message)),
        (data) {
      _topics = data;
      emit(TopicsLoadingSuccess(_topics));
    });
  }

  List<Forum> _userForums = [];
  List<Forum> get userForums => _userForums;
  Future<void> _loadUserForums(
      LoadUserForum event, Emitter<TopicState> emit) async {
    emit(UserForumsLoading());
    final result = await loadUserForumsUsecase(event.userID);
    result.fold((l) => emit(UserForumsFailed(l.message)), (data) {
      _userForums = data;
      emit(UserForumsSuccess(data));
    });
  }
}
