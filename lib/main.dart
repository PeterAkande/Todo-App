import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos_database_hive/todos_database_hive.dart';
import 'package:todo_app/screens/todo_list_home_screen/todo_list_home_screen.dart';
import 'package:todo_app/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TodoTheme.light(),
      darkTheme: TodoTheme.dark(),
      home: const TodoListHomeScreen(),
    );
  }
}
