import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/screens/my_drawer.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

import '../models/task.dart';

class ReceycleBin extends StatefulWidget {
  static const id = 'receycle_bin_screen';

  const ReceycleBin({Key? key}) : super(key: key);

  @override
  State<ReceycleBin> createState() => _ReceycleBinState();
}

class _ReceycleBinState extends State<ReceycleBin> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
        List<Task> tasksList = state.removedTasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Receycle bin'),

          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    '${tasksList.length} Tasks',
                  ),
                ),
              ),
              TasksList(tasksList:tasksList)
            ],
          ),
        );
      },
    );
  }
}
