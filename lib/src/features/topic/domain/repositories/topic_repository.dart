import 'package:dartz/dartz.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';

abstract class TopicRepository {
  Future<Either<Failure, List<Topic>>> loadTopics();
}
