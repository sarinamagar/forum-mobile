import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_comment_votes/comment_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class UpvoteCommentUsecase extends BaseUseCase<bool, CommentVoteRequestDto> {
  final PostRepository postRepository;

  UpvoteCommentUsecase({required this.postRepository});
  @override
  Future<Either<Failure, bool>> call(CommentVoteRequestDto dto) {
    return postRepository.upvoteComment(dto);
  }
}
