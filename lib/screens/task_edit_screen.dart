import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/services/guid.gen.dart';

import '../models/task.dart';

class EditTaskWidget extends StatelessWidget {
  final Task oldTask;
  const EditTaskWidget({
    Key? key,
    required this.oldTask
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      TextEditingController titleController = TextEditingController(text: oldTask.title);
      TextEditingController descriptionController = TextEditingController(text: oldTask.desctiption);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
        const Text("Edit Task", style: TextStyle(fontSize: 24.0)),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(top:10,bottom:10),
          child: TextField(controller: titleController, 
            autofocus: true,
            decoration: const InputDecoration(
            label: Text("Title"),
            border: OutlineInputBorder()
          ),),
        ),

         TextField(controller: descriptionController, 
          autofocus: true,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
          label: Text("Description"),
          border: OutlineInputBorder()
        ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('cancel')),
            ElevatedButton(onPressed: (){
              var editedTask = Task(
                title: titleController.text,
                id: oldTask.id,
                isDone: false,
                desctiption: descriptionController.text,
                isFavorite: oldTask.isFavorite,
                date: DateTime.now().toIso8601String()
                );
              context.read<TasksBloc>().add(EditTask(oldTask: oldTask,newTask: editedTask));
              Navigator.pop(context);
            }, child: const Text('save')),
          ],
        )
      ],),
    );
  }
}
