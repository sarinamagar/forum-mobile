import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase extends BaseUseCase<User, ResetPasswordRequestDto> {
  final AuthRepository authRepository;

  ResetPasswordUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(ResetPasswordRequestDto dto) {
    return authRepository.resetPassword(dto);
  }
}