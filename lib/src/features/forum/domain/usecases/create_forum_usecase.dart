import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/forum/data/dto/create_forum/create_forum_request_dto.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';

class CreateForumUsecase extends BaseUseCase<Forum, CreateForumRequestDto> {
  final ForumRepository forumRepository;

  CreateForumUsecase({required this.forumRepository});
  @override
  Future<Either<Failure, Forum>> call(CreateForumRequestDto dto) {
    return forumRepository.createForum(dto);
  }
}
