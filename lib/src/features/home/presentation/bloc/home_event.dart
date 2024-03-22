part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadPosts extends HomeEvent {}

class ChangeScreenModule extends HomeEvent {
  final int index;

  const ChangeScreenModule(this.index);
}

class FetchUserById extends HomeEvent {
  final String userID;

  const FetchUserById({required this.userID});
}

class UpdateStatus extends HomeEvent {
  final String userID;
  const UpdateStatus({required this.userID});
}

class SignOut extends HomeEvent {}
