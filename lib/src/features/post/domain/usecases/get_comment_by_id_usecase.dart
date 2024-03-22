import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class GetCommentByIdUsecase extends BaseUseCase<Comment, String> {
  final PostRepository postRepository;

  GetCommentByIdUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Comment>> call(String dto) {
    return postRepository.getCommentById(dto);
  }
}
