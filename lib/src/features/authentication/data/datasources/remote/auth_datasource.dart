import 'package:forum/src/core/models/remote/user/user_api_model.dart';
import 'package:forum/src/features/authentication/data/dto/reset_password/reset_password_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signin/sign_in_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';
import 'package:forum/src/features/authentication/data/dto/verify_account/verify_acc_request_dto.dart';

abstract class AuthDataSource {
  Future<UserApiModel> signUp(SignUpRequestDto dto);
  Future<UserApiModel> signIn(SignInRequestDto dto);
  Future<bool> verifyAcccount(VerifyAccRequestDto dto);
  Future<String> sendResetOtp(String email);
  Future<UserApiModel> resetPassword(ResetPasswordRequestDto dto);
}
