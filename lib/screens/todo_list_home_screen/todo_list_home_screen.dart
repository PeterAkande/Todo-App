import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_repository/todo_repository.dart';

import '../../responsive_info.dart';
import '../../routers/cubit/todo_app_cubit.dart';
import 'blocs/todo_bloc.dart';
import 'components/empty_todos_view.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({Key? key}) : super(key: key);

  final ResponsiveInfoRepo responsiveInfoRepo = ResponsiveInfoRepo();

  @override
  Widget build(BuildContext context) {
    responsiveInfoRepo.init(context);
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '13, Thursday, 2022',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(fontSize: 30),
                  ),
                  Row(
                    //
                    children: [
                      Text(
                        'Your Todos',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              iconSize: 20,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                  'assets/icons/filter_icon.svg'),
                            ),
                            IconButton(
                              iconSize: 25,
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 44,
                  ),
                  Expanded(
                    child: state.todos.isEmpty
                        ? const EmptyTodosView()
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              TodoModel todoModel = state.todos[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  color:
                                      const Color(0xFFD2D2D2).withOpacity(0.3),
                                  height: 90,
                                  child: Material(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<TodoAppCubit>()
                                            .selectTodo(todoModel);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          return Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth * 0.75,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      todoModel.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3
                                                          ?.copyWith(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      todoModel
                                                          .additionalContents,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4
                                                          ?.copyWith(
                                                            fontSize: 15,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      iconSize: 25,
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                          Icons.edit_outlined),
                                                    ),
                                                    Checkbox(
                                                        side: const BorderSide(
                                                            color:
                                                                Colors.black),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        fillColor:
                                                            const MaterialStatePropertyAll(
                                                          Colors.transparent,
                                                        ),
                                                        checkColor:
                                                            Colors.black,
                                                        value:
                                                            todoModel.completed,
                                                        onChanged:
                                                            (bool? value) {})
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
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: state.todos.length),
                  )
                ],
              ),
            ),
            floatingActionButton: responsiveInfoRepo.isMobile
                ? FloatingActionButton(
                    onPressed: () {
                      context.read<TodoAppCubit>().createNewTodo();
                    },
                    child: const Icon(Icons.add),
                  )
                : null);
      },
    );
  }
}
