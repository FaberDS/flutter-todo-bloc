import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/receycle_bin.dart';
import 'package:flutter_tasks_app/screens/tabs_screen.dart';
import 'package:flutter_tasks_app/screens/pending_screen.dart';

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
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(TabsScreen.id),
              child: ListTile(
                  leading: const Icon(Icons.folder_special),
                  title: const Text("My Tasks"),
                  trailing: Text("${state.pendingTasks.length} | ${state.completedTasks.length}")),
            );
          },
        ),
        const Divider(),
        BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed(ReceycleBin.id),
              child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text("Bin"),
                  trailing: Text("${state.removedTasks.length}")),
            );
          },
        ),
        BlocBuilder<SwitchBloc, SwitchState>(
          builder: (context, state) {
            return Switch(
                value: state.switchValue,
                onChanged: (newValue) {
                    newValue 
                      ? context.read<SwitchBloc>().add(SwitchOnEvent())
                      : context.read<SwitchBloc>().add(SwitchOffEvent());
                  ;
                });
          },
        )
      ],
    )));
  }
}
