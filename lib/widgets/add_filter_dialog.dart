import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodel/filters_notifier.dart';
import 'package:todo_app/models/todofilter.dart';

class AddFilterDialog extends StatefulWidget {
  
  @override
  _AddFilterDialog createState() => _AddFilterDialog();
}

class _AddFilterDialog extends State<AddFilterDialog> {
  final dataTextController = TextEditingController();

  @override
  Widget build(BuildContext context){
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
        autofocus: true,
        keyboardType: TextInputType.number,
      ),
      actions: actions,
    );

    return dialog;
  }
}