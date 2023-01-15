import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_amartha_test/src/models/task_model.dart';
import 'package:todo_app_amartha_test/src/utilities/utilities.dart';

part 'update_complete_task_state.dart';

class UpdateCompleteTaskCubit extends Cubit<UpdateCompleteTaskState> {
  UpdateCompleteTaskCubit() : super(UpdateCompleteTaskInitial());

  void updateTask(TaskModel task) {
    emit(UpdateCompleteTaskIsLoading());
    TaskModel updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
    );
    HiveCommons().updateTask(task: updatedTask).then((value) {
      emit(UpdateCompleteTaskIsSuccess(StringName.updateTaskString));
    }).onError((error, stackTrace) {
      emit(UpdateCompleteTaskIsFailed(error.toString()));
    });
  }
}
