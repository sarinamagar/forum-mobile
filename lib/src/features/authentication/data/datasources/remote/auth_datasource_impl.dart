import 'package:dio/dio.dart';
import 'package:forum/src/core/error/failure.dart';
import 'package:forum/src/core/http/api_endpoints.dart';
import 'package:forum/src/core/http/handle_error_response.dart';
import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/core/shared_prefs/user_shared_prefs.dart';
import 'package:forum/src/features/authentication/data/datasources/remote/auth_datasource.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_response_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_response_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_response_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_response_dto.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final Dio dio;

  AuthDataSourceImpl({required this.dio});

  @override
  Future<UserApiModel> signUp(SignUpRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.register, data: dto.toJson());
      if (res.statusCode == 200) {
        SignUpResponseDto signInResponseDto =
            SignUpResponseDto.fromJson(res.data);
        return signInResponseDto.data;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<UserApiModel> signIn(SignInRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.login, data: dto.toJson());
      if (res.statusCode == 200) {
        SignInResponseDto signInResponseDto =
            SignInResponseDto.fromJson(res.data);
        print("Res data ${res.data}");
        final UserSharedPref userSharedPref = UserSharedPref();
        userSharedPref.setUserToken(signInResponseDto.token);
        return signInResponseDto.user;
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

  @override
  Future<bool> verifyAcccount(VerifyAccRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.verifyAccount, data: dto.toJson());
      if (res.statusCode == 200) {
        VerifyAccResponseDto verifyAccResponseDto =
            VerifyAccResponseDto.fromJson(res.data);
        return verifyAccResponseDto.verified;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<String> sendResetOtp(String email) async {
    try {
      var res = await dio.post("${ApiEndpoints.sendResetOtp}$email");
      if (res.statusCode == 200) {
        return res.data['message'];
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusCode.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }

  @override
  Future<UserApiModel> resetPassword(ResetPasswordRequestDto dto) async {
    try {
      var res = await dio.post(ApiEndpoints.resetPassword, data: dto.toJson());
      if (res.statusCode == 200) {
        ResetPasswordResponseDto resetPasswordResponseDto =
            ResetPasswordResponseDto.fromJson(res.data);
        return resetPasswordResponseDto.user;
      } else {
        throw Failure(
            message: res.statusMessage.toString(),
            statusCode: res.statusMessage.toString());
      }
    } on DioException catch (e) {
      return await handleErrorResponse(e);
    }
  }
}
