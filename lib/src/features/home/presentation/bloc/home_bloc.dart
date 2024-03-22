import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/fetch_user_by_id_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/load_posts_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/signout_usecase.dart';
import 'package:forum/src/features/home/domain/usecases/update_status_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadPostUsecase loadPostUsecase;
  final FetchUserByIdUsecase fetchUserByIdUsecase;
  final UpdateStatusUsecase updateStatusUsecase;
  final SignOutUseCase signOutUseCase;
  HomeBloc({
    required this.loadPostUsecase,
    required this.fetchUserByIdUsecase,
    required this.updateStatusUsecase,
    required this.signOutUseCase,
  }) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeLoadPosts) {
        await _loadPosts(event, emit);
      }
      if (event is ChangeScreenModule) {
        _changeScreenModule(event, emit);
      }
      if (event is FetchUserById) {
        _fetchUserById(event, emit);
      }
      if (event is UpdateStatus) {
        _updateStatus(event, emit);
      }
      if (event is SignOut) {
        _signOut(event, emit);
      }
    });
  }
  List<Post> _posts = [];
  List<Post> get posts => _posts;
  Future<void> _loadPosts(HomeLoadPosts event, Emitter<HomeState> emit) async {
    emit(HomePostsLoading());
    final result = await loadPostUsecase(NoParams());
    result.fold((failure) => emit(HomePostsLoadingFailed(failure.message)),
        (data) {
      _posts = data;
      _posts.sort((a, b) {
        final aTime = DateTime.parse(a.postDate);
        final bTime = DateTime.parse(b.postDate);
        return bTime.compareTo(aTime);
      });
      emit(HomePostsLoadingSuccess(_posts));
    });
  }

  void _changeScreenModule(ChangeScreenModule event, Emitter<HomeState> emit) {
    emit(ScreenModuleChanged(event.index));
  }

  Future<void> _fetchUserById(
      FetchUserById event, Emitter<HomeState> emit) async {
    emit(FetchUserByIdLoading());
    final result = await fetchUserByIdUsecase(event.userID);
    result.fold(
      (failure) => emit(FetchUserByIdFailed(failure.message)),
      (success) => emit(FetchUserByIdSuccess(success)),
    );
  }

  String _status = "";
  String get status => _status;
  set userStatus(String value) {
    _status = value;
  }

  Future<void> _updateStatus(
      UpdateStatus event, Emitter<HomeState> emit) async {
    final result = await updateStatusUsecase(event.userID);
    result.fold(
      (l) => emit(UpdateStatusFailed(l.message)),
      (r) {
        _status = r.userInfo.status!;
      },
    );
  }

  _signOut(SignOut event, Emitter<HomeState> emit) async {
    emit(ProfileSigningOut());
    final res = await signOutUseCase(null);
    res.fold(
      (l) => emit(ProfileSignOutFailed(l.message)),
      (r) => emit(ProfileSignOutSuccess()),
    );
  }
}
