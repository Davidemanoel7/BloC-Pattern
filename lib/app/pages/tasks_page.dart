import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pattern_bloc/app/data/blocs/task_bloc.dart';
import 'package:pattern_bloc/app/data/blocs/task_event.dart';
import 'package:pattern_bloc/app/data/blocs/task_state.dart';
import 'package:pattern_bloc/app/data/model/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  late final TaskBloc _taskBloc;

  @override
  void initState() { 
    super.initState();
    // Assim que for inicializado o taskBloc, teremos um ouvinte
    // Ver no construtor de TaskBloc.
    _taskBloc = TaskBloc();
    _taskBloc.add( GetTask() );
  }

  @override
  void dispose() { 
    _taskBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BLoC Pattern',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: ( context, state ) {
          if ( state is TaskLoadingState ) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple
              )
            );
          } else if ( state is TaskLoadedState ) {
            final list = state.tasks;

            return ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: list.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Center(
                      child: Text( list[index].name[0] ),
                    ),
                  ),
                  title: Text( list[index].name ),
                  trailing: IconButton(
                    onPressed: () {
                      _taskBloc.add( DeleteTask( task: list[index] ));
                    },
                    icon: const Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Something has wrong'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskBloc.add( PostTask( task: Task( name: 'Task ${randomInt()}') ));
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  int randomInt() {
    var rand = Random();
    return rand.nextInt(100);
  }
}