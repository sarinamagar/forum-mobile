import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/usecase/base_usecase.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';
import 'package:forum/src/features/topic/domain/repositories/topic_repository.dart';

class LoadTopicUsecase extends BaseUseCase<List<Topic>, NoParams> {
  final TopicRepository topicRepository;

  LoadTopicUsecase({required this.topicRepository});
  @override
  Future<Either<Failure, List<Topic>>> call(NoParams dto) {
    return topicRepository.loadTopics();
  }
}
