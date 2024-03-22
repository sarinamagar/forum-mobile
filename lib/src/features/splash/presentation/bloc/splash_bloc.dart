import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/features/splash/domain/usecases/get_current_user_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUserUsecase getCurrentUser;
  SplashBloc({required this.getCurrentUser}) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is StartUpEvent) {
        await _splashGetCurrentUser(event, emit);
      }
    });
  }
  Future<void> _splashGetCurrentUser(
      StartUpEvent event, Emitter<SplashState> emit) async {
    emit(StartupLoading());

    final result = await getCurrentUser(NoParams());
    result.fold(
      (left) => emit(SplashGetUserFailed()),
      (right) => emit(SplashGetUserSuccessfully(user: right)),
    );
  }
}
