import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart' as u;
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';

abstract class AuthRepository {
  Future<Either<Failure, u.User>> signUp(SignUpRequestDto dto);
  Future<Either<Failure, u.User>> signIn(SignInRequestDto dto);
  Future<Either<Failure, bool>> verifyAccount(VerifyAccRequestDto dto);
  Future<Either<Failure, String>> sendResetOtp(String email);
  Future<Either<Failure, u.User>> resetPassword(ResetPasswordRequestDto dto);
}
