import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/features/forum/data/datasources/local/forum_local_datasource.dart';
import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';

class ForumLocalDatasourceImpl implements ForumLocalDataSource {
  @override
  List<ForumHiveModel> loadForums() {
    final List<ForumHiveModel> forums = AppBoxes.forumBox.values.map((forum) {
      return forum;
    }).toList();
    print("Appboxes ${forums}");
    return forums;
  }
}
