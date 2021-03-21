import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _tabs = const <Widget>[
    Tab(
      icon: Icon(Icons.cloud_outlined),
    ),
    Tab(
      icon: Icon(Icons.cloud_outlined),
    ),
    Tab(
      icon: Icon(Icons.cloud_outlined),
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
        children: const <Widget>[
          Center(
            child: Text('It\'s cloudy here'),
          ),
          Center(
            child: Text('It\'s rainy here'),
          ),
          Center(
            child: Text('It\'s sunny here'),
          ),
        ],
      ),
    );
  }
}
