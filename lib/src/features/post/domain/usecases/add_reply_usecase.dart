import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/entities/post/comment.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_reply/add_reply_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class AddReplyUsecase extends BaseUseCase<Comment, AddReplyRequestDto> {
  final PostRepository postRepository;

  AddReplyUsecase({required this.postRepository});
  @override
  Future<Either<Failure, Comment>> call(AddReplyRequestDto dto) {
    return postRepository.addReply(dto);
  }
}
