import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/appBar.dart';
import 'package:todo_app/widgets/todo_builder.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
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
        appBar: TodoAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 3),
            Expanded(
              flex: 5,
              child: todo_builder,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
