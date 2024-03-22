import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/forum/domain/repositories/forum_repository.dart';

class ForumPostsUsecase extends BaseUseCase<List<Post>, String> {
  final ForumRepository forumRepository;

  ForumPostsUsecase({required this.forumRepository});
  @override
  Future<Either<Failure, List<Post>>> call(String dto) {
    return forumRepository.forumPosts(dto);
  }
}
