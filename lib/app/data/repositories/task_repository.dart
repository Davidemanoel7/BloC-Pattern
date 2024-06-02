import 'package:pattern_bloc/app/data/model/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  Future<List<Task>> getTasks( ) async {
    _tasks.addAll([ 
      Task(name: 'Cozinhar'),
      Task(name: 'Tomar Banho'),
      Task(name: 'Dormir'),
      Task(name: 'Beber água') 
    ]);

    return Future.delayed(
      const Duration( seconds: 2),
      () => _tasks,
    );
  }

  Future<List<Task>> postTask({ required Task task }) async {
    _tasks.add(task);

    return Future.delayed(
      const Duration( seconds: 2),
      () => _tasks,
    );
  }

  Future<List<Task>> deleteTask({ required Task task }) async {
    _tasks.remove(task);

    return Future.delayed(
      const Duration( seconds: 2),
      () => _tasks,
    );
  }
}