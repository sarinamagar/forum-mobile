part of 'authentication_bloc.dart';

sealed class AuthenticationState {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSignUpLoading extends AuthenticationState {
  const AuthenticationSignUpLoading();
}

class AuthSignUpSuccess extends AuthenticationState {
  final User user;
  const AuthSignUpSuccess({required this.user});
}

class AuthSignupError extends AuthenticationState {
  final String message;
  const AuthSignupError(this.message);
}

class VerifyAccountLoading extends AuthenticationState {
  const VerifyAccountLoading();
}

class VerifyAccountSuccess extends AuthenticationState {
  final bool verified;

  VerifyAccountSuccess({required this.verified});
}

class VerifyAccountError extends AuthenticationState {
  final String message;
  const VerifyAccountError(this.message);
}

class AuthSignInLoading extends AuthenticationState {
  const AuthSignInLoading();
}

class AuthSignInSuccess extends AuthenticationState {
  final User user;
  const AuthSignInSuccess({required this.user});
}

class AuthSignInError extends AuthenticationState {
  final String message;

  AuthSignInError({required this.message});
}

class SendResetOtpLoading extends AuthenticationState {
  const SendResetOtpLoading();
}

class SendResestOtpSuccess extends AuthenticationState {
  final String message;
  final String email;

  SendResestOtpSuccess({required this.message, required this.email});
}

class SendResetOtpError extends AuthenticationState {
  final String message;

  SendResetOtpError({required this.message});
}

class ResetPasswordLoading extends AuthenticationState {
  const ResetPasswordLoading();
}

class ResetPasswordSuccess extends AuthenticationState {
  final User user;

  ResetPasswordSuccess({required this.user});
}

class ResetPasswordError extends AuthenticationState {
  final String message;

  ResetPasswordError({required this.message});
}
