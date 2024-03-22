import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/local/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthLocalRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource authLocalDataSource;

  AuthLocalRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, User>> signUp(SignUpRequestDto dto) async {
    try {
      final UserHiveModel userApiModel = await authLocalDataSource.signUp(dto);
      return Right(userApiModel.toUserDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyAccount(VerifyAccRequestDto dto) {
    // TODO: implement verifyAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signIn(SignInRequestDto dto) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> sendResetOtp(String email) {
    // TODO: implement sendResetOtp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> resetPassword(ResetPasswordRequestDto dto) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
