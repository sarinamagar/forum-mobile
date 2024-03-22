import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class UpvotePostUsecase extends BaseUseCase<bool, AddVoteRequestDto> {
  final PostRepository postRepository;

  UpvotePostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, bool>> call(AddVoteRequestDto dto) {
    return postRepository.upvotePost(dto);
  }
}
