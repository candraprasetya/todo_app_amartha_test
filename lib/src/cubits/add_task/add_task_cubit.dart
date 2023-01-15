import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_amartha_test/src/models/task_model.dart';
import 'package:todo_app_amartha_test/src/utilities/utilities.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());

  void addNewTask(String title, String subtitle, {bool addMoreTask = false}) {
    emit(AddTaskIsLoading());
    if (title.isEmpty) {
      emit(AddTaskIsFailed('Title cant be empty'));
    } else {
      HiveCommons()
          .addTask(
        task: TaskModel.create(title: title, subtitle: subtitle),
      )
          .then((value) {
        emit(AddTaskIsSuccess(StringName.addNewTask, addMoreTask));
      }).onError((error, stackTrace) {
        emit(AddTaskIsFailed(error.toString()));
      });
    }
  }
}
