import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/homepage.dart';
import 'package:todo_app/model/todo.dart';

final TODO_ALL = 0;
final TODO_INCOMP = 1;
final TODO_COMP = 2;

void main() {
  return runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo",
        theme: ThemeData(
          accentColor: Colors.orange,
          primaryColor: const Color(0xFFDE4435),
        ),
        home: HomePage(),
      ),
    );
  }
}
