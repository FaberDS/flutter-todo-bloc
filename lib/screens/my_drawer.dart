import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc/tasks_bloc.dart';
import 'package:flutter_tasks_app/screens/receycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';

import '../blocs/bloc_exports.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
            child: Column(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            color: Colors.grey,
            child: Text("Task Drawer",
                style: Theme.of(context).textTheme.headlineSmall)),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(TasksScreen.id),
              child: ListTile(
                  leading: Icon(Icons.folder_special),
                  title: Text("My Tasks"),
                  trailing: Text("${state.allTasks.length}")),
            );
          },
        ),
        const Divider(),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(ReceycleBin.id),
              child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text("Bin"),
                  trailing: Text("${state.removedTasks.length}")),
            );
          },
        )
      ],
    )));
  }
}
