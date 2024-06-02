import 'package:pattern_bloc/app/data/model/task.dart';

abstract class TaskEvent {}

class GetTask extends TaskEvent {}

class PostTask extends TaskEvent {
  final Task task;

  PostTask({ required this.task });
}

class DeleteTask extends TaskEvent {
  final Task task;

  DeleteTask({ required this.task });
}