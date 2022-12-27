import 'package:flutter/material.dart';

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
          children: const [
            LeftPanelView(),
            Expanded(flex: 2, child: HomeScreenView()),
            Expanded(
              flex: 3,
              child: TodoDetailsScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      color: Colors.pink,
    );
  }
}
