import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';
import 'package:todo_app/widgets/detail.dart';

class TodoBuilder extends StatefulWidget {
  List<Todo> todos;

  TodoBuilder(this.todos);
  @override
  _TodoBuilderState createState() => _TodoBuilderState();
}

class _TodoBuilderState extends State<TodoBuilder>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var todo_provider = Provider.of<TodoProvider>(context);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          Todo _todo = widget.todos[index];

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) => DetailPage(_todo),
                ),
              );
            },
            child: Stack(
              children: [
                Container(
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
                            Container(
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
                                onSelected: (setting) {
                                  switch (setting) {
                                    case TodoCardSettings.edit:
                                      print("edit");
                                      break;
                                    case TodoCardSettings.delete:
                                      print("delete clicked");
                                      todo_provider.deleteTodo(_todo);
                                      break;
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                _todo.description,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
