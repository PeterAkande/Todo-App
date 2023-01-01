import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routers/cubit/todo_app_cubit.dart';
import 'package:todo_app/routers/router_delegate.dart';
import 'package:todo_app/screens/todo_details_screen/bloc/todo_details_bloc.dart';
import 'package:todo_app/screens/todo_list_home_screen/blocs/todo_bloc.dart';
import 'package:todo_app/theme.dart';
import 'package:todo_repository/todo_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TodoAppCubit _appState = TodoAppCubit();
  final TodoRepository _todoRepository = TodoRepository()..init();

  late final TodoAppDelegate _todoAppRouterDelegate =
      TodoAppDelegate(_appState);

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _appState),
        BlocProvider(
            create: (context) => TodoDetailsBloc(_appState, _todoRepository)
              ..add(TodoDetailsSubscriptionRequested())),
        BlocProvider(
            create: (context) =>
                TodoBloc(_todoRepository)..add(TodoSubscriptionRequested()))
      ],

      //Using Navigation 2.0
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _todoAppRouterDelegate,
        theme: TodoTheme.light(),
        darkTheme: TodoTheme.dark(),
      ),
    );
  }
}
