import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';

import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/list/list_item.dart';

class TodoList extends StatelessWidget {
  int _status;

  TodoList(this._status);

  List<Todo> _getList(context) {
    final todolists = Provider.of<TodoProvider>(context).itemsList;
    if (_status == TODO_COMP) {
      todolists.where((e) => e.isCheckd == true);
    } else if (_status == TODO_INCOMP) {
      todolists.where((e) => e.isCheckd == false);
    }

    return todolists;
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todolists = _getList(context);

    return ListView.builder(
      itemCount: todolists.length,
      itemBuilder: (context, index) {
        return ListItem(todolists[index]);
      },
    );
  }
}
