import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/forum/data/dto/join_forum/join_forum_request_dto.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';

class JoinForumUsecase extends BaseUseCase<Forum, JoinForumRequestDto> {
  final ForumRepository forumRepository;

  JoinForumUsecase({required this.forumRepository});
  @override
  Future<Either<Failure, Forum>> call(JoinForumRequestDto dto) {
    return forumRepository.joinForum(dto);
  }
}
