import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_amartha_test/src/app.dart';
import 'package:todo_app_amartha_test/src/models/models.dart';
import 'package:todo_app_amartha_test/src/utilities/utilities.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(BoxName.task);
  runApp(const MyApp());
}
