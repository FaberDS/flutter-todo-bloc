import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;

  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislike;

  const PopupMenu(
      {Key? key, required this.task, 
      required this.cancelOrDeleteCallback,
      required this.likeOrDislike
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        label: const Text("Edit"),
                        icon: const Icon(Icons.edit)),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        label:  task.isFavorite == false 
                          ? const Text("Add to Bookmark's")
                          : const Text("Remove from Bookmark's"),
                        icon: task.isFavorite == false 
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                          ),
                    onTap: likeOrDislike,
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        label: const Text("Delete"),
                        icon: const Icon(Icons.delete)),
                    onTap: cancelOrDeleteCallback,
                  ),
                ])
            : ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        label: const Text("Restore"),
                        icon: const Icon(Icons.restore_from_trash)),
                    onTap: () {},
                  ),
                    PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: null,
                        label: const Text("Delete forever"),
                        icon: const Icon(Icons.delete_forever)),
                    onTap: cancelOrDeleteCallback,
                  )
                ]));
  }
}

// ListTile(
//       title: Text(
//         "${task.title}",
//         overflow: TextOverflow.ellipsis,
//         style: TextStyle(decoration: task.isDone! ? TextDecoration.lineThrough: null),),
//       trailing: Checkbox(
//         value: task.isDone,  
//         onChanged: task.isDeleted == false 
//         ? (value) {
//           context.read<TasksBloc>().add(UpdateTask(task: task));}
//         : null,
//       ),
    
//       onLongPress:  ()=> _removeOrDeleteTask(context,task)
//     );
//   }