import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class SendResetOtpUsecase extends BaseUseCase<String, String> {
  final AuthRepository authRepository;

  SendResetOtpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, String>> call(String dto) {
    return authRepository.sendResetOtp(dto);
  }
}
