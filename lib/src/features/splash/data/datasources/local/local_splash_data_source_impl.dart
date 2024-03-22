import 'package:forum/src/core/models/local/user/user_hive_model.dart';

abstract class LocalSplashDataSource {
  UserHiveModel? getCurrentUser();
}
