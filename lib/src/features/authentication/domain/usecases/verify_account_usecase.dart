import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class VerifyAccountUsecase extends BaseUseCase<bool, VerifyAccRequestDto> {
  final AuthRepository authRepository;

  VerifyAccountUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(VerifyAccRequestDto dto) {
    return authRepository.verifyAccount(dto);
  }
}
