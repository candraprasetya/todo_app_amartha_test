part of 'update_complete_task_cubit.dart';

@immutable
abstract class UpdateCompleteTaskState {}

class UpdateCompleteTaskInitial extends UpdateCompleteTaskState {}

class UpdateCompleteTaskIsLoading extends UpdateCompleteTaskState {}

class UpdateCompleteTaskIsFailed extends UpdateCompleteTaskState {
  final String message;

  UpdateCompleteTaskIsFailed(this.message);
}

class UpdateCompleteTaskIsSuccess extends UpdateCompleteTaskState {
  final String message;

  UpdateCompleteTaskIsSuccess(this.message);
}
