// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ForumHiveModelAdapter extends TypeAdapter<ForumHiveModel> {
  @override
  final int typeId = 4;

  @override
  ForumHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ForumHiveModel(
      id: fields[0] as String?,
      forumName: fields[1] as String?,
      iconUrl: fields[2] as String?,
      coverUrl: fields[3] as String?,
      description: fields[4] as String?,
      createdBy: fields[5] as UserHiveModel?,
      members: (fields[6] as List?)?.cast<UserHiveModel>(),
      rules: (fields[7] as List?)?.cast<String>(),
      isNSFW: fields[8] as bool?,
      tags: (fields[9] as List?)?.cast<String>(),
      posts: (fields[10] as List?)?.cast<PostHiveModel>(),
      createdAt: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ForumHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.forumName)
      ..writeByte(2)
      ..write(obj.iconUrl)
      ..writeByte(3)
      ..write(obj.coverUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.createdBy)
      ..writeByte(6)
      ..write(obj.members)
      ..writeByte(7)
      ..write(obj.rules)
      ..writeByte(8)
      ..write(obj.isNSFW)
      ..writeByte(9)
      ..write(obj.tags)
      ..writeByte(10)
      ..write(obj.posts)
      ..writeByte(11)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForumHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
