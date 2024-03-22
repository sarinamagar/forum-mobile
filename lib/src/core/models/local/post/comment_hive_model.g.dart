// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentHiveModelAdapter extends TypeAdapter<CommentHiveModel> {
  @override
  final int typeId = 3;

  @override
  CommentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommentHiveModel(
      id: fields[0] as String?,
      commentText: fields[1] as String,
      userID: fields[2] as UserHiveModel,
      upvotes: (fields[3] as List?)?.cast<UserHiveModel>(),
      downvotes: (fields[4] as List?)?.cast<UserHiveModel>(),
      replies: (fields[5] as List?)?.cast<CommentHiveModel>(),
      createdAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CommentHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.commentText)
      ..writeByte(2)
      ..write(obj.userID)
      ..writeByte(3)
      ..write(obj.upvotes)
      ..writeByte(4)
      ..write(obj.downvotes)
      ..writeByte(5)
      ..write(obj.replies)
      ..writeByte(6)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
