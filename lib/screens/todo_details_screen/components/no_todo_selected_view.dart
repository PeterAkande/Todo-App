import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoTodoSelectedView extends StatelessWidget {
  const NoTodoSelectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/no_selected_todo.svg',
            height: 200,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'No Todo Selected ✌',
            style: Theme.of(context).textTheme.headline3,
          )
        ],
      ),
    );
  }
}
