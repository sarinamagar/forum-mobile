import 'package:forum/src/core/constants/app_boxes.dart';
import 'package:forum/src/core/models/local/user/user_hive_model.dart';
import 'package:forum/src/features/splash/data/datasources/local/local_splash_data_source_impl.dart';

class LocalSplashDataSourceImpl implements LocalSplashDataSource {
  @override
  UserHiveModel? getCurrentUser() {
    final userBox = AppBoxes.userBox;
    final user = userBox.get(userBox);
    return user;
  }
}
