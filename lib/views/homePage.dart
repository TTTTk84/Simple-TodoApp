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
    notificationPlugin.init();
    Provider.of<TaskRepository>(context, listen: false).getReminderTask();

    double deviceW = MediaQuery.of(context).size.width;
    double deviceH = MediaQuery.of(context).size.height;
    var todo_provider = Provider.of<TodoRepository>(context, listen: false);
    var todo_builder = FutureBuilder(
      future: todo_provider.getAll(),
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
                builder: (cctx, todo, child) => TodoBuilder(todo.todo_items),
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
              child: todo_builder,
            ),
          ],
        ),
      ),
    );
  }
}
