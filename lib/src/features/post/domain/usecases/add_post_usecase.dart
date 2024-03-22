import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/post.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_post/add_post_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class AddPostUsecase extends BaseUseCase<Post, AddPostRequestDto> {
  final PostRepository postRepository;

  AddPostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Post>> call(AddPostRequestDto dto) {
    return postRepository.addPost(dto);
  }
}
