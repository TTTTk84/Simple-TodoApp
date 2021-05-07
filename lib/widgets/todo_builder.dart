import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/todoTileUI.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/views/task_builderPage.dart';
import 'package:todo_app/widgets/todoModal.dart';

class TodoBuilder extends StatelessWidget {
  List<Todo> todos;

  TodoBuilder(this.todos);

  @override
  Widget build(BuildContext context) {
    var todo_provider = Provider.of<TodoRepository>(context);
    var task_provider = Provider.of<TaskRepository>(context);
    task_builder(Todo _todo) => FutureBuilder(
          future: task_provider.getTasks(_todo.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Text('loading...');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Consumer<TaskRepository>(
                    builder: (cctx, task, child) =>
                        TaskBuilder(_todo, task_provider.task_items),
                  );
            }
          },
        );

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          Todo _todo = todos[index];
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => task_builder(_todo),
                ),
              );
            },
            child: todoTileUI(_todo, context),
          );
        });
  }
}
