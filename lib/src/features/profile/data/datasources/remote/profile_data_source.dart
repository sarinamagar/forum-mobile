import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';

abstract class ProfileDataSource {
  Future<List<PostApiModel>> userPosts(String userID);
  Future<UserApiModel> updateUser(UpdateUserRequestDto dto);
}
