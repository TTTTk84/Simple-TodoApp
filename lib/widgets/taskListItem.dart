import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';

Widget listItem(Task _task, BuildContext context) {
  void _checkItem() async {
    await Provider.of<TaskRepository>(context, listen: false)
        .changeCheck(_task);
  }

  return GestureDetector(
    onTap: () {
      _checkItem();
    },
    child: Dismissible(
      key: Key(_task.description),
      background: Container(color: Colors.red),
      confirmDismiss: (direction) async {
        await Provider.of<TaskRepository>(context, listen: false).delete(_task);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Checkbox(
                value: _task.is_checked,
                onChanged: (_) => _checkItem(),
                activeColor: Color(0xFF1111E6).withOpacity(0.6),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                '${_task.description}',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '2020-01-01',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
