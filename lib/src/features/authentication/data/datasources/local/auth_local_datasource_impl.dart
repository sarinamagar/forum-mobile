import 'package:forum/src/core/error/exceptions.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/core/models/local/user/user_info_hive_model.dart';
import 'package:forum/src/core/network/hive_service.dart';
import 'package:forum/src/core/utils/hash_password.dart';
import 'package:forum/src/features/authentication/data/datasources/local/auth_local_datasource.dart';
import 'package:forum/src/features/authentication/data/dto/signup/sign_up_request_dto.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveService hive;

  AuthLocalDataSourceImpl({required this.hive});

  @override
  Future<UserHiveModel> signUp(SignUpRequestDto dto) async {
    try {
      String hashedPassword = hashPassword(dto.password);
      UserInfoHiveModel useInfo = UserInfoHiveModel(
        username: dto.username,
        email: dto.email,
        password: hashedPassword,
        status: '',
      );
      UserHiveModel user = UserHiveModel(userInfo: useInfo);
      await hive.addUserToBox(user);
      return user;
    } on Exception {
      throw HiveException();
    }
  }

  @override
  Future<UserHiveModel> signIn(SignUpRequestDto dto) {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}
