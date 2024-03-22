import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class DownvoteCommentUsecase extends BaseUseCase<void, CommentVoteRequestDto> {
  final PostRepository postRepository;

  DownvoteCommentUsecase({required this.postRepository});
  @override
  Future<Either<Failure, void>> call(CommentVoteRequestDto dto) {
    return postRepository.downvoteComment(dto);
  }
}
