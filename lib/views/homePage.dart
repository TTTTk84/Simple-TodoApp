import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';
import 'package:todo_app/widgets/appBar.dart';
import 'package:todo_app/utils/notification.dart';
import 'package:todo_app/widgets/todo_builder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _taskProvider = Provider.of<TaskRepository>(context, listen: false);
    var _todoProvider = Provider.of<TodoRepository>(context, listen: false);
    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;

    notificationPlugin.init();
    _taskProvider.getReminderTask();
    var _todoBuilder = FutureBuilder(
      future: _todoProvider.getAll(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text('loading...');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return Consumer<TodoRepository>(
                builder: (cctx, todo, child) => TodoBuilder(todo.todoItems),
              );
        }
      },
    );

    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.24),
          child: TodoAppBar(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: deviceH * 0.24),
            Container(
              height: deviceH * 0.35,
              child: _todoBuilder,
            ),
          ],
        ),
      ),
    );
  }
}
