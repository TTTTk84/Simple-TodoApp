import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';
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
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 10.0,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              margin: EdgeInsets.fromLTRB(40, 0, 40, 8),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        Hero(
                          tag: _todo.id.toString() + '_background',
                          child: Container(
                            width: 180,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  const Color(0xFF1111E6).withOpacity(0.6),
                                  const Color(0xFF6A8FFF).withOpacity(0.6),
                                ],
                                stops: const [
                                  0.0,
                                  1.0,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 1,
                          child: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white38,
                            ),
                            itemBuilder: (context) =>
                                <PopupMenuEntry<TodoCardSettings>>[
                              PopupMenuItem(
                                child: Text("編集"),
                                value: TodoCardSettings.edit,
                              ),
                              PopupMenuItem(
                                child: Text("削除"),
                                value: TodoCardSettings.delete,
                              ),
                            ],
                            onSelected: (setting) async {
                              switch (setting) {
                                case TodoCardSettings.edit:
                                  String result = await showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return TodoModal(_todo, modalStatus.edit);
                                    },
                                  );
                                  if (result == null) return;
                                  break;
                                case TodoCardSettings.delete:
                                  await todo_provider.delete(_todo);
                                  break;
                              }
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Hero(
                            tag: _todo.id.toString() + '_description',
                            child: Text(
                              _todo.description,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
