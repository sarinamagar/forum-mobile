import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_comment/add_comment_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class AddCommentUseCase extends BaseUseCase<Comment, AddCommentRequestDto> {
  final PostRepository postRepository;

  AddCommentUseCase({required this.postRepository});
  @override
  Future<Either<Failure, Comment>> call(AddCommentRequestDto dto) {
    return postRepository.addComment(dto);
  }
}
