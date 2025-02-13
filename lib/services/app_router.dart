import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/screens/receycle_bin.dart';
import 'package:flutter_tasks_app/screens/tabs_screen.dart';
import 'package:flutter_tasks_app/screens/pending_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings){
    switch(routeSettings.name) {
      case ReceycleBin.id:
        return MaterialPageRoute(builder: (_) => const ReceycleBin());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => TabsScreen());
    default:
      return null;
    }
  }
}