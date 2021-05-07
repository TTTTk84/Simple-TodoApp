import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/widgets/reminderTile.dart';
import 'package:todo_app/widgets/taskListItem.dart';

class ReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    reminder_builder() => FutureBuilder(
          future: Provider.of<TaskRepository>(context, listen: false)
              .getReminderTask(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Text('loading...');
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                  return Consumer<TaskRepository>(
                    builder: (cctx, task, child) =>
                        ReminderCardBuilder(task.enabled_task_items),
                  );
            }
          },
        );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 40),
            child: Text(
              'リマインダー',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: reminder_builder(),
          ),
        ],
      ),
    );
  }
}
