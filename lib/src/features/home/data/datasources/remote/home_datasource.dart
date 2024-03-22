import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';

abstract class HomeDataSource {
  Future<UserApiModel> fetchUserById(String userID);
  Future<List<PostApiModel>> loadPosts();
  Future<UserApiModel> updateStatus(String userID);
  Future<void> signOut();
}
