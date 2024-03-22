part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthSignUp extends AuthenticationEvent {
  final SignUpRequestDto dto;

  const AuthSignUp({required this.dto});

  @override
  List<Object?> get props => [dto];
}

class AuthVerifyAccount extends AuthenticationEvent {
  final VerifyAccRequestDto dto;

  const AuthVerifyAccount({required this.dto});

  @override
  List<Object?> get props => [dto];
}

class AuthSignIn extends AuthenticationEvent {
  final SignInRequestDto dto;
  const AuthSignIn({required this.dto});

  @override
  List<Object?> get props => [dto];
}

class AuthSendResetOtp extends AuthenticationEvent {
  final String email;

  const AuthSendResetOtp({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthResetPassword extends AuthenticationEvent {
  final ResetPasswordRequestDto dto;

  const AuthResetPassword({required this.dto});

  @override
  List<Object?> get props => [dto];
}
