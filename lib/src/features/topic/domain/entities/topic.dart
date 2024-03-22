import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final String? id;
  final String name;
  final String? createdAt;

  const Topic({
    this.id,
    required this.name,
    this.createdAt,
  });
  @override
  List<Object?> get props => [name, createdAt];
}
