import 'package:dartz/dartz.dart';
import 'package:forum/src/core/domain/mappers/local/forum_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/forum_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/network/connectivity_checker.dart';
import 'package:forum/src/features/topic/data/datasources/local/topic_local_datasource.dart';
import 'package:forum/src/features/topic/data/datasources/remote/topic_datasource.dart';
import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';
import 'package:forum/src/features/topic/domain/entities/topic.dart';
import 'package:forum/src/features/topic/domain/repositories/topic_repository.dart';

class TopicRemoteRepository implements TopicRepository {
  final TopicDataSource topicDataSource;
  final BaseCheckInternetConnectivity checkInternetConnectivity;
  final TopicLocalDataSource topicLocalDataSource;

  TopicRemoteRepository({
    required this.topicDataSource,
    required this.checkInternetConnectivity,
    required this.topicLocalDataSource,
  });
  @override
  Future<Either<Failure, List<Topic>>> loadTopics() async {
    if (await checkInternetConnectivity.isConnected()) {
      try {
        List<TopicApiModel> topicsModel = await topicDataSource.loadTopics();
        List<Topic> topics =
            topicsModel.map((topic) => topic.toDomain()).toList();
        return Right(topics);
      } catch (e) {
        return Left(Failure(message: e.toString()));
      }
    } else {
      final topics = topicLocalDataSource.loadTopics();
      return Right(topics.map((e) => e.toApi().toDomain()).toList());
    }
  }
}
