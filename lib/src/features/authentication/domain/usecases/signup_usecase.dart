import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class SignUpUsecase extends BaseUseCase<User, SignUpRequestDto> {
  final AuthRepository authRepository;

  SignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(SignUpRequestDto dto) {
    return authRepository.signUp(dto);
  }
}

