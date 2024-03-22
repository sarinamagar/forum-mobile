import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/domain/usecases/reset_password_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/send_reset_otp_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/signin_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:forum/src/features/authentication/domain/usecases/verify_account_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpUsecase signUpUsecase;
  final VerifyAccountUsecase verifyAccountUsecase;
  final SignInUsecase signInUsecase;
  final SendResetOtpUsecase sendResetOtpUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;

  AuthenticationBloc({
    required this.signUpUsecase,
    required this.verifyAccountUsecase,
    required this.signInUsecase,
    required this.sendResetOtpUsecase,
    required this.resetPasswordUsecase,
  }) : super(AuthenticationInitial()) {
    {
      on<AuthenticationEvent>((event, emit) async {
        if (event is AuthSignUp) {
          await _signup(event, emit);
        }
        if (event is AuthVerifyAccount) {
          await _verifyAccount(event, emit);
        }
        if (event is AuthSignIn) {
          await _signIn(event, emit);
        }
        if (event is AuthSendResetOtp) {
          await _sendResetOtp(event, emit);
        }
        if (event is AuthResetPassword) {
          await _resetPassword(event, emit);
        }
      });
    }
  }
  Future<void> _signup(
      AuthSignUp event, Emitter<AuthenticationState> emit) async {
    emit(const AuthenticationSignUpLoading());
    final result = await signUpUsecase(event.dto);
    result.fold(
      (failure) => emit(AuthSignupError(failure.message)),
      (success) => emit(AuthSignUpSuccess(user: success)),
    );
  }

  Future<void> _verifyAccount(
      AuthVerifyAccount event, Emitter<AuthenticationState> emit) async {
    emit(const VerifyAccountLoading());
    final result = await verifyAccountUsecase(event.dto);
    result.fold(
      (failure) => emit(VerifyAccountError(failure.message)),
      (success) => emit(VerifyAccountSuccess(verified: success)),
    );
  }

  Future<void> _signIn(
      AuthSignIn event, Emitter<AuthenticationState> emit) async {
    emit(const AuthSignInLoading());
    final result = await signInUsecase(event.dto);
    result.fold(
      (failure) => emit(AuthSignInError(message: failure.message)),
      (success) => emit(AuthSignInSuccess(user: success)),
    );
  }

  Future<void> _sendResetOtp(
      AuthSendResetOtp event, Emitter<AuthenticationState> emit) async {
    emit(const SendResetOtpLoading());
    final result = await sendResetOtpUsecase(event.email);
    result.fold(
      (failure) => emit(SendResetOtpError(message: failure.message)),
      (success) =>
          emit(SendResestOtpSuccess(message: success, email: event.email)),
    );
  }

  Future<void> _resetPassword(
      AuthResetPassword event, Emitter<AuthenticationState> emit) async {
    emit(const ResetPasswordLoading());
    final result = await resetPasswordUsecase(event.dto);
    result.fold(
      (failure) => emit(ResetPasswordError(message: failure.message)),
      (success) => emit(ResetPasswordSuccess(user: success)),
    );
  }
}
