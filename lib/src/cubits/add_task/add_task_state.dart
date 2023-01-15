part of 'add_task_cubit.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskIsLoading extends AddTaskState {}

class AddTaskIsSuccess extends AddTaskState {
  final String message;
  final bool addMoreTask;

  AddTaskIsSuccess(this.message, this.addMoreTask);
}

class AddTaskIsFailed extends AddTaskState {
  final String message;

  AddTaskIsFailed(this.message);
}
