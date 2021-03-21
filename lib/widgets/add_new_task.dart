import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/model/todo.dart';

class AddNewTask extends StatefulWidget {
  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  String _inputDescription;
  final _formKey = GlobalKey<FormState>();

  void _PostForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Provider.of<TodoProvider>(context, listen: false).createNewTodo(Todo(
        id: DateTime.now().toString(),
        description: _inputDescription,
        isCheckd: false,
      ));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20,
        right: 40,
        left: 40,
        bottom: MediaQuery.of(context).size.height,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('タスク追加', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                print('value: $value');
                _inputDescription = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Center(
                child: SizedBox(
                  width: 300.0,
                  height: 40.0,
                  child: ElevatedButton(
                    child: Text(
                      "送　信",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      _PostForm();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
