import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTodosView extends StatelessWidget {
  const EmptyTodosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, -0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/no_todo_found.svg',
                height: 150,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'No Todo Found 🔍',
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
        ),
      ],
    );
  }
}
