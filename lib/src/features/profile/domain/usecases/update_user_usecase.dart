import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';
import 'package:forum/src/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserUsecase extends BaseUseCase<User, UpdateUserRequestDto> {
  final ProfileRepository profileRepository;

  UpdateUserUsecase({required this.profileRepository});
  @override
  Future<Either<Failure, User>> call(UpdateUserRequestDto dto) {
    return profileRepository.updateUser(dto);
  }
}
