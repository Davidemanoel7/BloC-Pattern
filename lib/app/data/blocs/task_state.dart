import 'package:pattern_bloc/app/data/model/task.dart';

abstract class TaskState {
  final List<Task> tasks;

  TaskState({ required this.tasks });
}

class TaskInitialState extends TaskState {
  TaskInitialState() : super( tasks: []);
}

class TaskLoadingState extends TaskState {
  TaskLoadingState() : super( tasks: []);
}

class TaskLoadedState extends TaskState {
  TaskLoadedState({ required List<Task> taskList}) : super( tasks: taskList );
}

class TaskErrorState extends TaskState {
  final Exception errorException;
  TaskErrorState({ required this.errorException }) : super( tasks: []);
}
