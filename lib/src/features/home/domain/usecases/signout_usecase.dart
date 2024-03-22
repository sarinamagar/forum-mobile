import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/home/domain/repositories/home_repository.dart';

class SignOutUseCase extends BaseUseCase<void, void> {
  final HomeRepository homeRepository;

  SignOutUseCase({required this.homeRepository});

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await homeRepository.signOut();
  }
}
