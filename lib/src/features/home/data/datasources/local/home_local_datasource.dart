import 'package:forum/src/core/models/local/post/post_hive_model.dart';

abstract class HomeLocalDataSource {
List<PostHiveModel> loadPosts();
}
