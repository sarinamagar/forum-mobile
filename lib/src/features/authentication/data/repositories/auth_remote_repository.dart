import 'package:dartz/dartz.dart';
import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/local/user_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/network/hive_service.dart';
import 'package:forum/src/core/shared_prefs/user_shared_prefs.dart';
import 'package:forum/src/features/authentication/data/datasources/remote/auth_datasource.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class AuthRemoteRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final HiveService hiveService;

  AuthRemoteRepositoryImpl(
      {required this.authDataSource, required this.hiveService});

  @override
  Future<Either<Failure, User>> signUp(SignUpRequestDto dto) async {
    try {
      final UserApiModel userApiModel = await authDataSource.signUp(dto);
      AppBoxes.userBox.put(AppBoxesKeys.user, userApiModel.fromApi());
      return Right(userApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyAccount(VerifyAccRequestDto dto) async {
    try {
      final bool verified = await authDataSource.verifyAcccount(dto);
      return Right(verified);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signIn(SignInRequestDto dto) async {
    try {
      final UserApiModel userApiModel = await authDataSource.signIn(dto);
      AppBoxes.userBox.put(AppBoxesKeys.user, userApiModel.fromApi());
      UserSharedPref.setUser(userApiModel.toDomain());
      return Right(userApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendResetOtp(String email) async {
    try {
      final String message = await authDataSource.sendResetOtp(email);
      return Right(message);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> resetPassword(
      ResetPasswordRequestDto dto) async {
    try {
      final UserApiModel userApiModel = await authDataSource.resetPassword(dto);
      return Right(userApiModel.toDomain());
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
