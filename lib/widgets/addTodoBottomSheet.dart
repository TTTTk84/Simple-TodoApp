import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';
import 'package:todo_app/widgets/addTodoContainer.dart';

class addTodoBottomSheet extends StatelessWidget {
  final AddModalStatus status;

  addTodoBottomSheet(this.status);

  @override
  Widget build(BuildContext context) {
    print('status $status');
    switch (status) {
      case AddModalStatus.add_todo:
        return addTodoContainer(context).todoContainer();
        break;
      case AddModalStatus.add_task:
        return addTodoContainer(context).taskContainer();
        break;
      default:
    }
  }
}
