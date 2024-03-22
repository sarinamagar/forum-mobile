part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomePostsLoading extends HomeState {}

class HomePostsLoadingSuccess extends HomeState {
  final List<Post> posts;

  const HomePostsLoadingSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class HomePostsLoadingFailed extends HomeState {
  final String message;

  const HomePostsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class FetchUserByIdLoading extends HomeState {}

class FetchUserByIdSuccess extends HomeState {
  final User user;

  const FetchUserByIdSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class FetchUserByIdFailed extends HomeState {
  final String message;

  const FetchUserByIdFailed(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateStatusLoading extends HomeState {}

class UpdateStatusSuccess extends HomeState {
  final User user;

  const UpdateStatusSuccess({required this.user});
}

class UpdateStatusFailed extends HomeState {
  final String message;

  const UpdateStatusFailed(this.message);
}

class ProfileSigningOut extends HomeState {}

class ProfileSignOutSuccess extends HomeState {}

class ProfileSignOutFailed extends HomeState {
  final String message;

  const ProfileSignOutFailed(this.message);
}

class ScreenModuleChanged extends HomeState {
  final int index;
  const ScreenModuleChanged(this.index);

  @override
  List<Object> get props => [index];
}
