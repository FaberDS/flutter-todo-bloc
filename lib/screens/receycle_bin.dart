import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/my_drawer.dart';
import 'package:flutter_tasks_app/widgets/tasks_list.dart';

class ReceycleBin extends StatelessWidget {
    static const id = 'receycle_bin_screen';

const ReceycleBin({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
          appBar: AppBar(
            title: const Text('Receycle bin'),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Center(
                child: Chip(
                  label: Text(
                    ' Tasks',
                  ),
                ),
              ),
              TasksList(tasksList: [])
            ],
          ),
        
        );
  }
}