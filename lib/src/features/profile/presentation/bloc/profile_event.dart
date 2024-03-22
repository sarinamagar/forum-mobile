part of '../viewmodels/profile_viewmodel.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoadPost extends ProfileEvent {
  final String userID;

  const ProfileLoadPost({required this.userID});
}

class UpdateUser extends ProfileEvent {
  final UpdateUserRequestDto dto;

  const UpdateUser({required this.dto});
}
