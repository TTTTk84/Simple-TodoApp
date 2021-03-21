import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/tabbar/all_task.dart';

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
          AllTask(),
          Center(
            child: Text('It\'s rainy here'),
          ),
          Center(
            child: Text('It\'s sunny here'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // showModalBottomSheet(
          //   context: context,
          //   builder: (_) => AddNewTodo(),
          // );
        },
      ),
    );
  }
}
