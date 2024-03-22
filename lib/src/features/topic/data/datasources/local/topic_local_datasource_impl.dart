import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/features/topic/data/datasources/local/topic_local_datasource.dart';
import 'package:forum/src/features/topic/data/models/local/topic_hive_model.dart';

class TopicLocalDatasourceImpl implements TopicLocalDataSource {
  @override
  List<TopicHiveModel> loadTopics() {
    final List<TopicHiveModel> topics = AppBoxes.topicBox.values.map((topic) {
      return topic;
    }).toList();
    print("Appboxes ${topics}");
    return topics;
  }
}
