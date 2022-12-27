import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/todo_details_screen/bloc/todo_details_bloc.dart';

class TodoDetailsScreen extends StatelessWidget {
  TodoDetailsScreen({Key? key}) : super(key: key);

  final TextEditingController todoTitleController = TextEditingController();
  final TextEditingController todoDetailsController = TextEditingController();

  final FocusNode todoTitleFocusNode = FocusNode();
  final FocusNode todoDetailsFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Edit todo',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              TextField(
                // enabled: todoTitleFocusNode,
                focusNode: todoTitleFocusNode,
                maxLines: null,
                maxLength: 50,
                buildCounter: buildCounterForTextField,
                // inputFormatters: inputFormatters(),
                controller: todoTitleController,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: 19,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
                decoration: InputDecoration(
                    hintText: 'Enter Title here..',
                    fillColor: Colors.red,
                    hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                          fontWeight: FontWeight.normal,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black.withOpacity(0.4)
                                  : Colors.white.withOpacity(0.4),
                        ),
                    border: InputBorder.none),
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              Expanded(
                child: TextField(
                  focusNode: todoDetailsFocusNode,
                  controller: todoDetailsController,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withOpacity(0.7)
                          : Colors.white),
                  maxLines: null,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Details of todo here...',
                    hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black.withOpacity(0.6)
                            : Colors.white.withOpacity(0.6),
                        fontSize: 19),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget? buildCounterForTextField(BuildContext context,
      {int? currentLength, bool? isFocused, int? maxLength}) {
    return null;
  }
}
