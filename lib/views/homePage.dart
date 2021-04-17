import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';
import 'package:todo_app/widgets/addTodoBottomSheet.dart';
import 'package:todo_app/widgets/appBar.dart';
import 'package:todo_app/widgets/todo_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todos = FutureBuilder(
    future: TodoRepository.getAll(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
        case ConnectionState.waiting:
          return Text('loading...');
        default:
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          else
            return TodoBuilder(snapshot.data);
      }
    },
  );
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: TodoAppBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 3),
            Expanded(
              flex: 5,
              child: todos,
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
