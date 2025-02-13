import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/services/guid.gen.dart';

import '../models/task.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      TextEditingController titleController = TextEditingController();
      TextEditingController descriptionController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
        const Text("Add Task", style: TextStyle(fontSize: 24.0)),
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
              var task = Task(
                title: titleController.text,
                id: GUIDGen.generate(),
                desctiption: descriptionController.text,
                isFavorite: false,
                date: DateTime.now().toIso8601String()
                );
              context.read<TasksBloc>().add(AddTask(task: task));
              Navigator.pop(context);
            }, child: const Text('add')),
          ],
        )
      ],),
    );
  }
}
