import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routers/cubit/todo_app_cubit.dart';

import '../responsive_info.dart';
import '../screens/todo_details_screen/todo_details_screen.dart';
import '../screens/todo_list_home_screen/todo_list_home_screen.dart';
import '../screens/todo_list_home_screen/todo_list_home_screen_desktop.dart';

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
  final GlobalKey<NavigatorState>
      _navigationKey; // The key is needed by the router delegate
  final ResponsiveInfoRepo _responsiveInfoRepo =
      ResponsiveInfoRepo(); //Would contain info about the current screen type

  TodoAppDelegate(TodoAppCubit appState)
      : _navigationKey = GlobalKey(),
        _appState = appState;

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigationKey;

  @override
  Widget build(BuildContext context) {
    _responsiveInfoRepo.init(context);
    return BlocConsumer<TodoAppCubit, TodoAppState>(
      //This _appState would would in most times only be changed when the details
      bloc: _appState,
      builder: (context, state) {
        return Navigator(
          onPopPage: (route, result) {
            if (route.didPop(result)) {
              //If a pop happens, let the native os handle it
              return true;
            }

            return false;
          },

          //The last page of this list is given preference
          pages: _responsiveInfoRepo.isMobile
              ? getMobilePagesConfig(state)
              : getDesktopPagesConfig(state),
        );
      },
      listener: (context, state) {
        //When the app State changes, call notify listeners so that the Navigator is rebuilt
        //The material app is a default listener of this router delegate.
        //So when notify listeners is called,
        notifyListeners();
      },
    );
  }

  List<Page<dynamic>> getMobilePagesConfig(TodoAppState state) {
    return [
      MaterialPage(child: HomeScreenView()),
      if (state.selectedTodo != null && _responsiveInfoRepo.isMobile)
        MaterialPage(child: TodoDetailsScreen())
    ];
  }

  List<Page<dynamic>> getDesktopPagesConfig(TodoAppState state) {
    return [
      const MaterialPage(child: TodoListHomeScreenDesktop()),
    ];
  }

  @override
  Future<void> setNewRoutePath(TodoPath configuration) async {
    //Do nothing.. No path would be shown since this does nothing
  }
}
