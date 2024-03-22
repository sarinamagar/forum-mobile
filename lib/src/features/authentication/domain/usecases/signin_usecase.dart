import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/domain/repositories/auth_repository.dart';

class SignInUsecase extends BaseUseCase<User, SignInRequestDto> {
  final AuthRepository authRepository;
  SignInUsecase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(SignInRequestDto dto) {
    return authRepository.signIn(dto);
  }
}
