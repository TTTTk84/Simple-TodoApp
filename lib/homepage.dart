import 'package:flutter/material.dart';

import 'package:todo_app/widgets/list/todolist.dart';
import 'package:todo_app/widgets/add_new_task.dart';
import 'package:todo_app/main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _tabs = const <Widget>[
    Tab(
      icon: Text("全て"),
    ),
    Tab(
      icon: Text("未達成"),
    ),
    Tab(
      icon: Text("達成済"),
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO リスト"),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TodoList(TODO_ALL),
          TodoList(TODO_INCOMP),
          TodoList(TODO_COMP),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => SingleChildScrollView(
              child: AddNewTask(),
            ),
          );
        },
      ),
    );
  }
}
