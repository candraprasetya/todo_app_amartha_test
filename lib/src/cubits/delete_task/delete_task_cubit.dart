import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_amartha_test/src/models/task_model.dart';
import 'package:todo_app_amartha_test/src/utilities/utilities.dart';

part 'delete_task_state.dart';

class DeleteTaskCubit extends Cubit<DeleteTaskState> {
  DeleteTaskCubit() : super(DeleteTaskInitial());

  void deleteTask(TaskModel task) {
    emit(DeleteTaskIsLoading());
    HiveCommons().dalateTask(task: task).then((value) {
      emit(DeleteTaskIsSuccess(StringName.deleteTask));
    }).onError((error, stackTrace) {
      emit(DeleteTaskIsFailed(error.toString()));
    });
  }
}
