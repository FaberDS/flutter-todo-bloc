import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/services/app_router.dart';
import 'package:path_provider/path_provider.dart';
import 'blocs/bloc_exports.dart';
import 'screens/tasks_screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

   HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const TasksScreen(),
        onGenerateRoute: appRouter.onGenerateRoute

      ),
    );
  }
}
