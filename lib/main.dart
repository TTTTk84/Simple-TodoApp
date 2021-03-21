import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/homepage.dart';
import 'package:todo_app/model/todo.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo",
        home: HomePage(),
      ),
    );
  }
}
