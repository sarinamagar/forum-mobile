import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/hive_table.dart';
import 'package:forum/src/core/models/local/user/user_info_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTable.userTableId)
class UserHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final UserInfoHiveModel userInfo;
  @HiveField(1)
  final int karma;
  @HiveField(2)
  final int? followers;
  @HiveField(3)
  final int? following;

  UserHiveModel({
    required this.userInfo,
    this.karma = 0,
    this.followers = 0,
    this.following = 0,
  });
  @override
  List<Object?> get props => [userInfo, karma, followers, following];
}
