import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/screens/todo_details_screen/bloc/todo_details_bloc.dart';

extension TextControllerExtension on TextEditingController {
  String getText() {
    return text.trim();
  }

  bool containsText() {
    return getText().isNotEmpty;
  }
}

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({Key? key}) : super(key: key);

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
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
                //
                children: [
                  Text(
                    state.addingOrEditingTodo ? 'Edit todo' : 'Todo Details',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 25,
                          onPressed: () {
                            if (todoTitleController.containsText()) {
                              //Save the _todo
                              context.read<TodoDetailsBloc>().add(
                                  SaveTodoDetailRequested(
                                      todoModel: state.todo,
                                      content: todoDetailsController.getText(),
                                      title: todoTitleController.getText(),
                                      completed: false));
                            }
                          },
                          icon: const Icon(Icons.save_outlined),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                // enabled: todoTitleFocusNode,
                cursorColor: Colors.black,

                focusNode: todoTitleFocusNode,
                maxLines: null,
                maxLength: 50,
                buildCounter: buildCounterForTextField,
                // inputFormatters: inputFormatters(),
                controller: todoTitleController,
                style: Theme.of(context).textTheme.headline3?.copyWith(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white),
                decoration: InputDecoration(
                    hintText: 'Enter Todo here..',
                    fillColor: Colors.red,
                    hintStyle: Theme.of(context).textTheme.headline3?.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black.withOpacity(0.4)
                            : Colors.white.withOpacity(0.4),
                        fontSize: 20),
                    border: InputBorder.none),
              ),
              Divider(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
              Expanded(
                child: TextField(
                  cursorColor: Colors.black,
                  focusNode: todoDetailsFocusNode,
                  controller: todoDetailsController,
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black.withOpacity(0.7)
                          : Colors.white),
                  maxLines: null,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Details of todo here...',
                    hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
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
