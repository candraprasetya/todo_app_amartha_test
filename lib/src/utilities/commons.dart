part of 'utilities.dart';

class HiveCommons {
  final Box<TaskModel> box = Hive.box<TaskModel>(BoxName.task);

  /// Add new Task
  Future<void> addTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  /// Show task
  Future<TaskModel?> getTask({required String id}) async {
    return box.get(id);
  }

  /// Update task
  Future<void> updateTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  /// Delete task
  Future<void> dalateTask({required TaskModel task}) async {
    await box.delete(task.id);
  }

  ValueListenable<Box<TaskModel>> listenToTask() {
    return box.listenable();
  }
}

class Commons {
  void showMySnackBar(BuildContext context, String message,
      {int statusId = 0}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: message.text.make(),
      backgroundColor: toastColor(statusId),
    ));
  }

  Color toastColor(int statusId) {
    switch (statusId) {
      case 0:
        return colorName.info;
      case 1:
        return colorName.success;
      case 2:
        return colorName.warning;
      case 3:
        return colorName.error;
      default:
        return colorName.black;
    }
  }
}
