import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/addTodoContainer.dart';

class addTodoBottomSheet extends StatelessWidget {
  final AddmodalStatus status;
  final formKey = GlobalKey<FormState>();

  addTodoBottomSheet(this.status);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AddmodalStatus.add_todo:
        return addTodoContainer(context, formKey).todoContainer();
        break;
      case AddmodalStatus.add_task:
        return addTodoContainer(context, formKey).taskContainer();
        break;
      default:
    }
  }
}
