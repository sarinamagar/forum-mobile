import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> addUserToBox(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(AppBoxesName.userBox);
    await box.put(user.userInfo.uid, user);
  }
}
