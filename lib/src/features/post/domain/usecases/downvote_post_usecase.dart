import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/post/data/dto/add_votes/add_vote_request_dto.dart';
import 'package:forum/src/features/post/domain/repositories/post_repository.dart';

class DownvotePostUsecase extends BaseUseCase<void, AddVoteRequestDto> {
  final PostRepository postRepository;

  DownvotePostUsecase({required this.postRepository});
  @override
  Future<Either<Failure, void>> call(AddVoteRequestDto dto) {
    return postRepository.downvotePost(dto);
  }
}
