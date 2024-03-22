import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/forum/domain/entities/forum.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';

class LoadJoinedForumsUsecase extends BaseUseCase<List<Forum>, String> {
  final ForumRepository forumRepository;

  LoadJoinedForumsUsecase({required this.forumRepository});

  @override
  Future<Either<Failure, List<Forum>>> call(String dto) {
    return forumRepository.loadJoinedForums(dto);
  }
}
