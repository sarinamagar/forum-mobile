import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class GetPostUsecase extends BaseUseCase<Post, String> {
  final PostRepository postRepository;

  GetPostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Post>> call(String dto) {
    return postRepository.getPost(dto);
  }
}
