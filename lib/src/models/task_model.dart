// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String subtitle;
  @HiveField(3)
  final DateTime createdAtTime;
  @HiveField(4)
  final DateTime createdAtDate;
  @HiveField(5)
  final bool isCompleted;

  TaskModel(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.createdAtTime,
      required this.createdAtDate,
      required this.isCompleted});

  factory TaskModel.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title ?? "",
        subtitle: subtitle ?? "-",
        createdAtTime: createdAtTime ?? DateTime.now(),
        isCompleted: false,
        createdAtDate: createdAtDate ?? DateTime.now(),
      );

  TaskModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdAtTime: createdAtTime ?? this.createdAtTime,
      createdAtDate: createdAtDate ?? this.createdAtDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
