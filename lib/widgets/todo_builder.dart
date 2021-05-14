import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/ui/todoTileUI.dart';
import 'package:todo_app/views/task_builderPage.dart';

class TodoBuilder extends StatelessWidget {
  TodoBuilder(this.todos);
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    var _todoProvider = Provider.of<TodoRepository>(context);
    var _taskProvider = Provider.of<TaskRepository>(context);
    _taskBuilder(Todo _todo) => FutureBuilder(
          future: _taskProvider.getTasks(_todo.id),
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
                        TaskBuilder(_todo, _taskProvider.taskItems),
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
                  builder: (BuildContext context) => _taskBuilder(_todo),
                ),
              );
            },
            child: todoTileUI(_todo, context),
          );
        });
  }
}
