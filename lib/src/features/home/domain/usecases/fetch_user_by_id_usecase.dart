import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/home/domain/repositories/home_repository.dart';

class FetchUserByIdUsecase extends BaseUseCase<User, String> {
  final HomeRepository homeRepository;

  FetchUserByIdUsecase({required this.homeRepository});
  @override
  Future<Either<Failure, User>> call(String dto) {
    return homeRepository.fetchUserByID(dto);
  }
}
