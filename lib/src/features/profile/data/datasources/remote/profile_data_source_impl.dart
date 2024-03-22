import 'package:dio/dio.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/remote/post/post_api_model.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/profile/data/datasources/remote/profile_data_source.dart';
import 'package:forum/src/features/profile/data/dto/update_user_request_dto.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final Dio dio;

  ProfileDataSourceImpl({required this.dio});
  @override
  Future<List<PostApiModel>> userPosts(String userID) async {
    try {
      final response = await dio.get("${ApiEndpoints.userPost}$userID");
      if (response.statusCode == 200) {
        final data = response.data['data'];
        final List<PostApiModel> posts = List<PostApiModel>.from(
          data.map((post) => PostApiModel.fromJson(post)),
        );
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
  Future<UserApiModel> updateUser(UpdateUserRequestDto dto) async {
    try {
      FormData userData = FormData();
      String fileName =
          dto.avatar != null ? dto.avatar!.path.split('/').last : '';
      userData.fields.addAll({
        // 'gender': dto.gender.toString(),
        'bio': dto.bio!,
      }.entries.map((entry) => MapEntry(entry.key, entry.value)));
      // if (dto.avatar != null) {
      //   userData.files.add(MapEntry(
      //     'avatar',
      //     await MultipartFile.fromFile(
      //       dto.avatar!.path,
      //       filename: fileName,
      //     ),
      //   ));
      // }
      print("dto.bio ${userData.fields}");
      var res = await dio.put("${ApiEndpoints.updateUser}${dto.userID}",
          data: userData);
      if (res.statusCode == 200) {
        Map<String, dynamic> data = res.data['data'];
        print("dto.bio ${data}");
        final UserApiModel user = UserApiModel.fromJson(data);
        return user;
      } else {
        throw Failure(
          message: res.statusMessage.toString(),
          statusCode: res.statusCode.toString(),
        );
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
