// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoHiveModelAdapter extends TypeAdapter<UserInfoHiveModel> {
  @override
  final int typeId = 1;

  @override
  UserInfoHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfoHiveModel(
      uid: fields[0] as String?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      password: fields[3] as String?,
      bio: fields[4] as String?,
      gender: fields[5] as String?,
      avatarUrl: fields[6] as String?,
      status: fields[7] as String?,
      verified: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfoHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.bio)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.avatarUrl)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.verified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
