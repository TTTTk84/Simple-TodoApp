import 'package:flutter/material.dart';
import 'package:todo_app/home.dart';
import 'package:todo_app/addpage.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // アプリ名
        title: 'My Todo App',
        theme: ThemeData(
          // テーマカラー
          primarySwatch: Colors.blue,
        ),
        // リスト一覧画面を表示
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => TodoListPage(),
          '/addpage': (BuildContext context) => TodoAddPage(),
        });
  }
}
