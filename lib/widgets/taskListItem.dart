import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/taskModal.dart';

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
                child: IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  onPressed: () async {
                    var result = await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) {
                        return TaskModal(_task, modalStatus.edit);
                      },
                    );
                    if (result == null) return;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
