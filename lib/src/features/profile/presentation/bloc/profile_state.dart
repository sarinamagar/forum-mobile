part of '../viewmodels/profile_viewmodel.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfilePostLoading extends ProfileState {}

class ProfilePostsLoadingSuccess extends ProfileState {
  final List<Post> posts;

  const ProfilePostsLoadingSuccess(this.posts);

  @override
  List<Object> get props => [posts];
}

class ProfilePostsLoadingFailed extends ProfileState {
  final String message;

  const ProfilePostsLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class UpdatingUser extends ProfileState {}

class UpdateUserSuccess extends ProfileState {
  final User user;

  const UpdateUserSuccess(this.user);
}

class UpdateUserFailed extends ProfileState {
  final String message;

  const UpdateUserFailed(this.message);
}
