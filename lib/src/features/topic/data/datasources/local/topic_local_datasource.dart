import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';

abstract class TopicLocalDataSource {
  List<TopicHiveModel> loadTopics();
}
