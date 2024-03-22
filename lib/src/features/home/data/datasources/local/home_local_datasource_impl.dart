import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/features/home/data/datasources/local/home_local_datasource.dart';

class HomeLocalDatasourceImpl implements HomeLocalDataSource {
  @override
  List<PostHiveModel> loadPosts() {
    final List<PostHiveModel> posts = AppBoxes.postBox.values.map((post) {
      return post;
    }).toList();
    print("Appboxes ${posts}");
    return posts;
  }
}
