import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:forum/src/core/constants/hive_table.dart';

part 'user_info_hive_model.g.dart';

@HiveType(typeId: HiveTable.userInfoTableId)
class UserInfoHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? uid;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final String? bio;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final String? avatarUrl;
  @HiveField(7)
  final String? status;
  @HiveField(8)
  final bool? verified;

  UserInfoHiveModel({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.bio,
    this.gender,
    this.avatarUrl,
    this.status,
    this.verified,
  });

  @override
  List<Object> get props {
    return [];
  }
}
