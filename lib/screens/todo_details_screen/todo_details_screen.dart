import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/routers/cubit/todo_app_cubit.dart';
import 'package:todo_app/screens/todo_details_screen/bloc/todo_details_bloc.dart';

import 'components/no_todo_selected_view.dart';

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
    return WillPopScope(
      onWillPop: () async {
        context.read<TodoAppCubit>().unSelectTodo();

        return true;
      },
      child: BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
        builder: (context, state) {
          updateEditingControllersText(state);
          updateTextFieldsFocus(state);

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
              child: (!state.addingOrEditingTodo && state.todo == null)
                  ? const NoTodoSelectedView()
                  : Column(
                      children: [
                        Row(
                          //
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<TodoAppCubit>().unSelectTodo();
                                },
                                icon: const Icon(Icons.cancel_outlined)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              state.addingOrEditingTodo
                                  ? 'Edit todo'
                                  : 'Todo Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
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
                                                content: todoDetailsController
                                                    .getText(),
                                                title: todoTitleController
                                                    .getText(),
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
                          controller: todoTitleController,
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.copyWith(
                                  fontSize: 20,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter Todo here..',
                              fillColor: Colors.red,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black.withOpacity(0.4)
                                          : Colors.white.withOpacity(0.4),
                                      fontSize: 20),
                              border: InputBorder.none),

                          onChanged: (String? value) {
                            if (value!.isNotEmpty) {
                              //A new text was entered
                              if (!state.addingOrEditingTodo) {
                                assert(
                                    state.todo != null); //For editing purpose
                                context
                                    .read<TodoDetailsBloc>()
                                    .add(EditTodoDetailsRequested(state.todo!));
                              }
                            }
                          },
                        ),
                        Divider(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.black,
                            focusNode: todoDetailsFocusNode,
                            controller: todoDetailsController,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black.withOpacity(0.7)
                                        : Colors.white),
                            maxLines: null,
                            autofocus: false,
                            decoration: InputDecoration(
                              hintText: 'Enter Details of todo here...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black.withOpacity(0.6)
                                          : Colors.white.withOpacity(0.6),
                                      fontSize: 19),
                              border: InputBorder.none,
                            ),
                            onChanged: (String? value) {
                              if (value!.isNotEmpty) {
                                //A new text was entered
                                if (!state.addingOrEditingTodo) {
                                  assert(
                                      state.todo != null); //For editing purpose
                                  context.read<TodoDetailsBloc>().add(
                                      EditTodoDetailsRequested(state.todo!));
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }

  Widget? buildCounterForTextField(BuildContext context,
      {int? currentLength, bool? isFocused, int? maxLength}) {
    return null;
  }

  void updateEditingControllersText(TodoDetailsState state) {
    //This function would handle what should be show in th etext fields.

    //Basically, if a new _todo is to be created, clear the text fields

    if (state.todo == null) {
      todoTitleController.text = '';
      todoDetailsController.text = '';
    } else {
      todoTitleController.text = state.todo!.title;
      todoDetailsController.text = state.todo!.additionalContents;
    }
  }

  void updateTextFieldsFocus(TodoDetailsState state) {
    //This function would handle what should be show in th etext fields.

    //Basically, if a new _todo is to be created, clear the text fields

    if (!state.addingOrEditingTodo) {
      todoDetailsFocusNode.unfocus();
      todoTitleFocusNode.unfocus();
    }
  }
}
