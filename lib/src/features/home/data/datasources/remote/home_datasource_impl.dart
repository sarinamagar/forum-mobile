import 'package:dio/dio.dart';
import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/domain/entities/user/user.dart';
import 'package:forum/src/core/domain/mappers/local/post_mappers.dart';
import 'package:forum/src/core/domain/mappers/remote/user_mappers.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/local/post/post_hive_model.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/shared_prefs/user_shared_prefs.dart';
import 'package:forum/src/features/home/data/datasources/remote/home_datasource.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final Dio dio;

  HomeDataSourceImpl({required this.dio});
  @override
  Future<List<PostApiModel>> loadPosts() async {
    try {
      await AppBoxes.postBox.clear();
      final response = await dio.get(ApiEndpoints.loadPosts);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostApiModel> posts = List<PostApiModel>.from(
          data.map((post) => PostApiModel.fromJson(post)),
        );
        if (posts.isNotEmpty) {
          await AppBoxes.postBox
              .addAll(List<PostHiveModel>.from(posts.map((e) => e.fromApi())));
        }
        return posts;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<UserApiModel> fetchUserById(String userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.fetchUserByID}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final UserApiModel user = UserApiModel.fromJson(data);
        return user;
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<UserApiModel> updateStatus(String userID) async {
    try {
      final response = await dio.post("${ApiEndpoints.updateStatus}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final UserApiModel userApiModel = await fetchUserById(data['_id']);
        final User user = userApiModel.toDomain();
        final updatedUserInfo = user.userInfo.copyWith(
          status: data['status'],
        );
        final updatedUser = user.copyWith(userInfo: updatedUserInfo);
        print("Updates User ${updatedUser.userInfo.status}");
        return updatedUser.fromDomain();
      } else {
        throw Failure(
            message: response.statusMessage.toString(),
            statusCode: response.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await UserSharedPref.deleteUser();
    } on Exception catch (_) {
      print('custom exception is been obtained');
    }
  }
}
