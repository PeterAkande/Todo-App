import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_list_home_screen/todo_list_home_screen.dart';

import '../../components/desktop_view_line_separator.dart';
import '../todo_details_screen/todo_details_screen.dart';
import 'components/left_pane_for_desktop_view.dart';

class TodoListHomeScreenDesktop extends StatelessWidget {
  const TodoListHomeScreenDesktop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const LeftPanelView(),
            const DeskTopViewsSeparator(),
            Expanded(flex: 2, child: HomeScreenView()),
            const Expanded(
              flex: 3,
              child: TodoDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
