import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/todo_details_screen/todo_details_screen.dart';

class TodoListHomeScreen extends StatelessWidget {
  const TodoListHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
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

class LeftPanelView extends StatelessWidget {
  const LeftPanelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      width: 80,
      color: Colors.red,
      child: Column(
        children: [
          SvgPicture.asset('icons/filter_icon.svg'),
          SizedBox(
            height: 30,
          ),
          SvgPicture.asset('icons/options_icon.svg'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(

                  ),
                  onPressed: () {},
                  child: const Icon(Icons.add),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
