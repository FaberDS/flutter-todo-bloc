import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/completed_tasks.dart';
import 'package:flutter_tasks_app/screens/favorite_tasks%20copy.dart';
import 'package:flutter_tasks_app/screens/my_drawer.dart';
import 'package:flutter_tasks_app/screens/task_add_screen.dart';
import 'package:flutter_tasks_app/screens/pending_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {"pageName": PendingTasksScreen(), 'title': "Pending Tasks"},
    {"pageName": CompletedTasksScreen(), 'title': "Completed Tasks"},
    {"pageName": FavoriteTasksScreen(), 'title': "Favorite Tasks"},
  ];

  var _selectedIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const AddTaskWidget()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(_pageDetails[_selectedIndex]['title']),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              )
            ]),
        drawer: const MyDrawer(),
        body: _pageDetails[_selectedIndex]['pageName'],
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () => _addTask(context),
                tooltip: 'Add Task',
                child: const Icon(Icons.add))
            : null,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle_sharp),
                label: "Pending Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.done), label: "Completed Tasks"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite Tasks")
          ],
        ));
  }
}
