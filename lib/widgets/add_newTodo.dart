import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/todo_provider.dart';

class AddNewTodo extends StatefulWidget {
  final AddDialogStatus status;

  List<String> get descriptionList {
    switch (this.status) {
      case AddDialogStatus.add_task:
        return ['タスクを追加', '腹筋'];
        break;
      case AddDialogStatus.add_todo:
        return ['カテゴリーを追加', '筋トレ'];
        break;
    }
  }

  AddNewTodo(this.status);
  @override
  _AddNewTodo createState() => _AddNewTodo();
}

class _AddNewTodo extends State<AddNewTodo> {
  final dataTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> description = widget.descriptionList;
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> actions = [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(localizations.cancelButtonLabel),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop<String>(context, dataTextController.text);
        },
        child: Text(localizations.okButtonLabel),
      ),
    ];

    final AlertDialog dialog = AlertDialog(
      title: Text("${description[0]}"),
      content: TextField(
        controller: dataTextController,
        decoration: InputDecoration(
          hintText: "${description[1]}",
        ),
        autofocus: false,
        keyboardType: TextInputType.text,
      ),
      actions: actions,
    );

    return dialog;
  }
}
