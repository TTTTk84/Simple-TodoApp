import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/list/todolist.dart';
import 'package:todo_app/main.dart';

class CompTask extends StatelessWidget {
  var _status = TODO_COMP;

  @override
  Widget build(BuildContext context) {
    return TodoList(_status);
  }
}
