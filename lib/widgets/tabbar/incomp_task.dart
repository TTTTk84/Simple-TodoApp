import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/list/todolist.dart';
import 'package:todo_app/main.dart';

class InCompTask extends StatefulWidget {
  var _status = TODO_INCOMP; //1

  @override
  _InCompTaskState createState() => _InCompTaskState();
}

class _InCompTaskState extends State<InCompTask> {
  @override
  Widget build(BuildContext context) {
    return TodoList(widget._status);
  }
}
