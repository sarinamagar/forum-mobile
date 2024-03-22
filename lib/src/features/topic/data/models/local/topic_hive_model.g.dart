// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopicHiveModelAdapter extends TypeAdapter<TopicHiveModel> {
  @override
  final int typeId = 5;

  @override
  TopicHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopicHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String,
      createdAt: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TopicHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
