import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/db/todo_repository.dart';

import 'package:todo_app/views/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List',
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          brightness: Brightness.light,
        ),
        home: HomePage(),
      ),
    );
  }
}
