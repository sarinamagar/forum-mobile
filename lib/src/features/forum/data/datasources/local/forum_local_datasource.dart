import 'package:forum/src/features/forum/data/models/local/forum_hive_model.dart';

abstract class ForumLocalDataSource {
  List<ForumHiveModel> loadForums();
}
