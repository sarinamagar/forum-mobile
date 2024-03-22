import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';

abstract class AuthLocalDataSource {
  Future<UserHiveModel> signUp(SignUpRequestDto dto);
  Future<UserHiveModel> signIn(SignUpRequestDto dto);
}
