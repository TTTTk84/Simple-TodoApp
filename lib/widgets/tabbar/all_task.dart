import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/list/todolist.dart';
import 'package:todo_app/main.dart';

class AllTask extends StatelessWidget {
  var _status = TODO_ALL;

  @override
  Widget build(BuildContext context) {
    return TodoList(_status);
  }
}
