import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/task_repository.dart';
import 'package:todo_app/db/todo_repository.dart';
import 'package:todo_app/validation/task_validation.dart';
import 'package:todo_app/validation/todo_validation.dart';
import 'package:todo_app/views/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoRepository>(
          create: (context) => TodoRepository(),
        ),
        ChangeNotifierProvider<TaskRepository>(
          create: (context) => TaskRepository(),
        ),
        ChangeNotifierProvider<TodoValidation>(
          create: (context) => TodoValidation(),
        ),
        ChangeNotifierProvider<TaskValidation>(
          create: (context) => TaskValidation(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          brightness: Brightness.light,
        ),
        home: SafeArea(
          child: HomePage(),
        ),
      ),
    );
  }
}
