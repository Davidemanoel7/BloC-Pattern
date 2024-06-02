import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pattern_bloc/app/data/blocs/task_event.dart';
import 'package:pattern_bloc/app/data/blocs/task_state.dart';
import 'package:pattern_bloc/app/data/model/task.dart';
import 'package:pattern_bloc/app/data/repositories/task_repository.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final _repository = TaskRepository();


  TaskBloc() : super( TaskInitialState() ) {
    // Ouvir todos os eventos enviados para o Bloc
    // _inputTaskController.stream.listen( _mapEventToState );
    on( _mapEventToState );
  }

  void _mapEventToState( TaskEvent taskEvent, Emitter emit ) async {
    List<Task> tasks = [];
    
    emit( TaskLoadingState() );

    if ( taskEvent is GetTask ) {
      tasks = await _repository.getTasks();
    } else if ( taskEvent is PostTask ) {
      tasks = await _repository.postTask( task: taskEvent.task );
    } else if ( taskEvent is DeleteTask ) {
      tasks = await _repository.deleteTask( task: taskEvent.task );
    }

    emit( TaskLoadedState( taskList: tasks ));
  }
}