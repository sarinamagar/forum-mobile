import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/error/failure.dart';

abstract class SplashRepository {
  Future<Either<Failure, User?>> getCurrentUser();
}
