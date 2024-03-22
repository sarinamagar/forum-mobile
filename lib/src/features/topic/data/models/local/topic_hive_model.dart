import 'package:equatable/equatable.dart';
import 'package:forum/src/core/constants/hive_table.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'topic_hive_model.g.dart';

@HiveType(typeId: HiveTable.topicTableId)
class TopicHiveModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? createdAt;

  TopicHiveModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [name, createdAt];
}
