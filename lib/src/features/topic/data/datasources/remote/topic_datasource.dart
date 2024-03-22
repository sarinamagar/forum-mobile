import 'package:forum/src/features/topic/data/models/remote/topic_api_model.dart';

abstract class TopicDataSource {
  Future<List<TopicApiModel>> loadTopics();
}
