import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';

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
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.todos.length,
        itemBuilder: (context, index) {
          Todo _todo = widget.todos[index];

          return InkWell(
            onTap: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     fullscreenDialog: true,
              //     builder: (BuildContext context) => DetailPage(_todo),
              //   ),
              // );
            },
            child: Center(
              child: Container(
                child: Stack(
                  children: [
                    Hero(
                      tag: _todo.uuid + '_back',
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
                color: Colors.white,
                width: 300.0,
                height: 300.0,
                margin: EdgeInsets.fromLTRB(50, 60, 50, 60),
              ),
            ),
          );
        });
  }
}
