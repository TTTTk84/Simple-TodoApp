import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/viewmodel/filters_notifier.dart';
import 'package:todo_app/widgets/homepage.dart';

void main() {
  return runApp(TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FiltersNotifier(),
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
