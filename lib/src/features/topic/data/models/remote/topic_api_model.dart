import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class TopicApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? createdAt;

  const TopicApiModel({
    this.id,
    required this.name,
    this.createdAt,
  });

  @override
  List<Object?> get props => [name, createdAt];

  factory TopicApiModel.fromJson(Map<String, dynamic> json) {
    return TopicApiModel(
      id: json['_id'],
      name: json['name'],
      createdAt: json['createdAt'],
    );
  }
}
