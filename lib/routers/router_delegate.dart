import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routers/cubit/todo_app_cubit.dart';

import '../responsive_info.dart';
import '../screens/todo_details_screen/todo_details_screen.dart';
import '../screens/todo_list_home_screen/todo_list_home_screen.dart';

enum TodoPath { home }

class TodoAppDelegate extends RouterDelegate<TodoPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  /*
  Okay.. some explanations as to why the ChangeNotifier is implemented here.
  It is actually not needed. But if it wasn't there, we would actually need to override the
  addListeners method. We can actually add it as
    @override
    void addListener(VoidCallback listener) {
      //When a new state is emitted, it should call the listener
      appState.stream.listen((event) {
        listener;
      });
    }

    But. lets not disturb ourselves so much.. So all we have to do is just attach a bloc listener and call notifyListeners from
    the changeNotifier class. Another method is also to just do in the constructor block:

    appState.stream.listen((event) => notifyListeners())
   */

  final TodoAppCubit _appState;
  final GlobalKey<NavigatorState> _navigationKey;
  final ResponsiveInfoRepo
      _responsiveInfoRepo = ResponsiveInfoRepo(); //Would contain info about the current screen type

  TodoAppDelegate(TodoAppCubit appState)
      : _navigationKey = GlobalKey(),
        _appState = appState;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigationKey;

  @override
  Widget build(BuildContext context) {
    _responsiveInfoRepo.init(context);
    return BlocConsumer<TodoAppCubit, TodoAppState>(
      bloc: _appState,
      builder: (context, state) {

        return Navigator(
          onPopPage: (route, result) {
            if (route.didPop(result)) {
              return true;
            }

            return false;
          },
          pages: [
            const MaterialPage(child: TodoListHomeScreen()),
            if (state.selectedTodo == null && _responsiveInfoRepo.isMobile)
              const MaterialPage(child: TodoDetailsScreen())
          ],
        );
      },
      listener: (context, state) {
        //When the app State changes, call notify listeners so that the Navigator is rebuilt
        notifyListeners();
      },
    );
  }

  @override
  Future<void> setNewRoutePath(TodoPath configuration) async {}
}
