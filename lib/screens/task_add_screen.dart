import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

import '../models/task.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
      TextEditingController titleController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
        Text("Add Task", style: TextStyle(fontSize: 24.0)),
        const SizedBox(height: 20),
        TextField(controller: titleController, 
          autofocus: true,
          decoration: const InputDecoration(
          label: Text("Title"),
          border: OutlineInputBorder()
        ),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(onPressed: ()=>Navigator.pop(context), child: Text('cancel')),
            ElevatedButton(onPressed: (){
              var task = Task(title: titleController.text,);
              context.read<TasksBloc>().add(AddTask(task: task));
              Navigator.pop(context);
            }, child: Text('add')),
          ],
        )
      ],),
    );
  }
}
