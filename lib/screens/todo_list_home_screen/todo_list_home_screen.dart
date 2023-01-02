import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/todo_list_home_screen/components/todo_tile.dart';
import 'package:todo_repository/todo_repository.dart';

import '../../responsive_info.dart';
import '../../routers/cubit/todo_app_cubit.dart';
import 'blocs/todo_bloc.dart';
import 'components/empty_todos_view.dart';

class HomeScreenView extends StatelessWidget {
  HomeScreenView({Key? key}) : super(key: key) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: appSecondaryColorLight));
  }

  final ResponsiveInfoRepo responsiveInfoRepo = ResponsiveInfoRepo();

  @override
  Widget build(BuildContext context) {
    responsiveInfoRepo.init(context);

    return SafeArea(
      child: BlocBuilder<TodoBloc, TodoState>(
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
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
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
                      height: 5,
                    ),
                    Divider(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white,
                    ),
                    const SizedBox(
                      height: 39,
                    ),
                    Expanded(
                      child: state.todos.isEmpty
                          ? const EmptyTodosView()
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                TodoModel todoModel = state.todos[index];
                                return TodoTile(todoModel: todoModel);
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
      ),
    );
  }
}
