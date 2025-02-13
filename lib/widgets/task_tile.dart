import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/widgets/popup_menu.dart';
import 'package:intl/intl.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import '../screens/task_edit_screen.dart';

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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: EditTaskWidget(oldTask: task)),
            ));
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
              PopupMenu(
                task: task,
                cancelOrDeleteCallback: ()=> _removeOrDeleteTask(context,task),
                likeOrDislike: ()=> context.read<TasksBloc>().add(MarkFavoriteOrUnfavoriteTask(task: task)),
                editTaskCallback: (){
                  // Navigator.of(context).pop();
                  _editTask(context);
                  },
                  restoreTaskCallback: () => context.read<TasksBloc>().add(RestoreTask(task: task))
                  )
            ],
          ),
        ],
      ),
    );
  }
}
