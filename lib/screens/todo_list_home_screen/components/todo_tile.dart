import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_repository/todo_repository.dart';

import '../../../routers/cubit/todo_app_cubit.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todoModel;

  const TodoTile({Key? key, required this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: const Color(0xFFD2D2D2).withOpacity(0.3),
        height: 90,
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<TodoAppCubit>().selectTodo(todoModel);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: LayoutBuilder(builder: (context, constraints) {
                return Row(
                  children: [
                    SizedBox(
                      width: constraints.maxWidth * 0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todoModel.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            todoModel.additionalContents,
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      fontSize: 15,
                                    ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 25,
                            onPressed: () {},
                            icon: const Icon(Icons.edit_outlined),
                          ),
                          Checkbox(
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                              fillColor: const MaterialStatePropertyAll(
                                Colors.transparent,
                              ),
                              checkColor: Colors.black,
                              value: todoModel.completed,
                              onChanged: (bool? value) {})
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
