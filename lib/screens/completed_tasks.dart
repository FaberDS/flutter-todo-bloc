import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

import '../models/task.dart';

class CompletedTasksScreen extends StatelessWidget {
 const CompletedTasksScreen({Key? key}) : super(key: key);
  static const id = 'completed_tasks_id';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasksList = state.completedTasks;
        return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(
                child: Chip(
                  label: Text(
                    '${tasksList.length} Tasks',
                  ),
                ),
              ),
              TasksList(tasksList: tasksList)
            ],
        );
      },
    );
  }
}

