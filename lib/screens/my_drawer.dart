import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/receycle_bin.dart';
import 'package:flutter_tasks_app/screens/tasks_screen.dart';

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
        GestureDetector(
          onTap: ()=>Navigator.of(context).pushNamed(TasksScreen.id),
          child: const ListTile(
              leading: Icon(Icons.folder_special),
              title: Text("My Tasks"),
              trailing: Text("0")),
        ),
        const Divider(),
        GestureDetector(
          onTap: ()=>Navigator.of(context).pushNamed(ReceycleBin.id),
          child: const ListTile(
            leading: Icon(Icons.delete),
            title: Text("Bin"),
            trailing: Text("0")),
        )
      ],
    )));
  }
}
