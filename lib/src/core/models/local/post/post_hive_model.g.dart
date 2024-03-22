// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostHiveModelAdapter extends TypeAdapter<PostHiveModel> {
  @override
  final int typeId = 2;

  @override
  PostHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostHiveModel(
      id: fields[0] as String?,
      caption: fields[1] as String,
      publisher: fields[5] as UserHiveModel,
      postDate: fields[8] as String,
      description: fields[2] as String?,
      postMediaUrl: fields[3] as String?,
      postLink: fields[4] as String?,
      isNSFW: fields[6] as bool,
      shares: fields[7] as int,
      comments: (fields[9] as List?)?.cast<CommentHiveModel>(),
      upvotes: (fields[10] as List?)?.cast<UserHiveModel>(),
      downvotes: (fields[11] as List?)?.cast<UserHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostHiveModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.caption)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.postMediaUrl)
      ..writeByte(4)
      ..write(obj.postLink)
      ..writeByte(5)
      ..write(obj.publisher)
      ..writeByte(6)
      ..write(obj.isNSFW)
      ..writeByte(7)
      ..write(obj.shares)
      ..writeByte(8)
      ..write(obj.postDate)
      ..writeByte(9)
      ..write(obj.comments)
      ..writeByte(10)
      ..write(obj.upvotes)
      ..writeByte(11)
      ..write(obj.downvotes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
