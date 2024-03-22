import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/splash/domain/repositories/splash_repository.dart';

class GetCurrentUserUsecase extends BaseUseCase<User?, NoParams> {
  final SplashRepository splashRepository;

  GetCurrentUserUsecase({required this.splashRepository});

  @override
  Future<Either<Failure, User?>> call(NoParams dto) {
    return splashRepository.getCurrentUser();
  }
}
