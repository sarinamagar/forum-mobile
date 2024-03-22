import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/profile/domain/repositories/profile_repository.dart';

class UserPostUsecase extends BaseUseCase<List<Post>, String> {
  final ProfileRepository profileRepository;

  UserPostUsecase({required this.profileRepository});

  @override
  Future<Either<Failure, List<Post>>> call(String dto) {
    return profileRepository.userPosts(dto);
  }
}
