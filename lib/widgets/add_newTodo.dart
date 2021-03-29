import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewTodo extends StatefulWidget {
  @override
  _AddNewTodo createState() => _AddNewTodo();
}

class _AddNewTodo extends State<AddNewTodo> {
  final dataTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      title: Text("カテゴリーを追加"),
      content: TextField(
        controller: dataTextController,
        decoration: InputDecoration(
          hintText: "筋トレ",
        ),
        autofocus: false,
        keyboardType: TextInputType.text,
      ),
      actions: actions,
    );

    return dialog;
  }
}
