import 'package:dio/dio.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/splash/data/datasources/local/local_splash_data_source_impl.dart';
import 'package:forum/src/features/splash/data/datasources/remote/remote_splash_data_source.dart';

class RemoteSplashDataSourceImpl implements RemoteSplashDataSource {
  final Dio dio;
  final LocalSplashDataSource localSplashDataSource;

  RemoteSplashDataSourceImpl(
      {required this.dio, required this.localSplashDataSource});

  @override
  Future<UserApiModel?> getCurrentUser(String? userID) async {
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
}
