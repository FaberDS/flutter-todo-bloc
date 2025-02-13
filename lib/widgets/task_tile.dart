import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/widgets/popup_menu.dart';
import 'package:intl/intl.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted!
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(task.isFavorite == false
                  ? Icons.star_outline
                  : Icons.star
                
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${task.title}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: task.isDone!
                                    ? TextDecoration.lineThrough
                                    : null)),
                        Text(DateFormat()
                            .add_yMEd()
                            .add_Hms()
                            .format(DateTime.parse(task.date)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: task.isDeleted == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null,
              ),
              PopupMenu(task: task,cancelOrDeleteCallback: ()=> _removeOrDeleteTask(context,task),likeOrDislike: ()=> context.read<TasksBloc>().add(MarkFavoriteOrUnfavoriteTask(task: task)), )
            ],
          ),
        ],
      ),
    );
  }
}
