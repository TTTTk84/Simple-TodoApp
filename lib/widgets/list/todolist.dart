import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/list/list_item.dart';

class TodoList extends StatefulWidget {
  int _status;

  TodoList(this._status);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    List<Todo> _getTodo() {
      // print('hello ${widget._status}');
      List<Todo> todolists = Provider.of<TodoProvider>(context).itemsList;

      if (widget._status == TODO_COMP) {
        todolists = todolists.where((e) => e.isCheckd == true).toList();
      } else if (widget._status == TODO_INCOMP) {
        todolists = todolists.where((e) => e.isCheckd == false).toList();
      }
      return todolists;
    }

    List<Todo> todolists = _getTodo();
    // print(todolists);

    return ListView.builder(
      itemCount: todolists.length,
      itemBuilder: (context, index) {
        return ListItem(todolists[index]);
      },
    );
  }
}
