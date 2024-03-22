import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/local/user_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/network/connectivity_checker.dart';
import 'package:forum/src/core/shared_prefs/user_shared_prefs.dart';
import 'package:forum/src/features/splash/data/datasources/local/local_splash_data_source_impl.dart';
import 'package:forum/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';
import 'package:forum/src/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final RemoteSplashDataSource remoteSplashDataSource;
  final LocalSplashDataSource localSplashDataSource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;

  SplashRepositoryImpl({
    required this.remoteSplashDataSource,
    required this.checkInternetConnectivity,
    required this.localSplashDataSource,
  });

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    User? userPref = await UserSharedPref.getUser();
    if (await checkInternetConnectivity.isConnected()) {
      try {
        if (userPref != null) {
          UserApiModel? userApiModel = await remoteSplashDataSource
              .getCurrentUser(userPref.userInfo.uid);
          User? user = userApiModel!.toDomain();
          return (Right(user));
        } else {
          return const Right(null);
        }
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      if (userPref != null) {
        return Right(userPref);
      } else {
        return const Right(null);
      }
    }
  }
}
