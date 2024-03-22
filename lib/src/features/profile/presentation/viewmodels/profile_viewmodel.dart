import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';
import 'package:forum/src/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:forum/src/features/profile/domain/usecases/user_posts_usecase.dart';

part '../bloc/profile_event.dart';
part '../bloc/profile_state.dart';

class ProfileViewModel extends Bloc<ProfileEvent, ProfileState> {
  final UserPostUsecase userPostUsecase;
  final UpdateUserUsecase updateUserUsecase;
  ProfileViewModel(
      {required this.userPostUsecase, required this.updateUserUsecase})
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileLoadPost) {
        await _profileLoadPost(event, emit);
      }
      if (event is UpdateUser) {
        await _updateUser(event, emit);
      }
    });
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;
  Future<void> _profileLoadPost(
      ProfileLoadPost event, Emitter<ProfileState> emit) async {
    emit(ProfilePostLoading());
    final result = await userPostUsecase(event.userID);
    result.fold((failure) => emit(ProfilePostsLoadingFailed(failure.message)),
        (data) {
      _posts = data;
      _posts.sort((a, b) {
        final aTime = DateTime.parse(a.postDate);
        final bTime = DateTime.parse(b.postDate);
        return bTime.compareTo(aTime);
      });
      emit(ProfilePostsLoadingSuccess(_posts));
    });
  }

  Future<void> _updateUser(UpdateUser event, Emitter<ProfileState> emit) async {
    emit(UpdatingUser());
    final result = await updateUserUsecase(event.dto);
    result.fold(
      (failure) => emit(UpdateUserFailed(failure.message)),
      (success) => emit(UpdateUserSuccess(success)),
    );
  }
}
