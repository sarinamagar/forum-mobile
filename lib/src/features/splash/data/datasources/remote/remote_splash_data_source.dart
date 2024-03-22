import 'package:forum/src/core/models/remote/user/user_api_model.dart';

abstract class RemoteSplashDataSource {
  Future<UserApiModel?> getCurrentUser(String? userID);
}
