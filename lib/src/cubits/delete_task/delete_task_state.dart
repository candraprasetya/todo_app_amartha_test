part of 'delete_task_cubit.dart';

@immutable
abstract class DeleteTaskState {}

class DeleteTaskInitial extends DeleteTaskState {}

class DeleteTaskIsLoading extends DeleteTaskState {}

class DeleteTaskIsFailed extends DeleteTaskState {
  final String message;

  DeleteTaskIsFailed(this.message);
}

class DeleteTaskIsSuccess extends DeleteTaskState {
  final String message;

  DeleteTaskIsSuccess(this.message);
}
