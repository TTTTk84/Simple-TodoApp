import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todofilter.dart';
import 'package:todo_app/viewmodel/filters_notifier.dart';
import 'package:todo_app/widgets/add_filter_dialog.dart';
import 'package:todo_app/widgets/todolist.dart';

import '../models/todofilter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _limitCount = 4;
  List<Widget> _todoWidgets = [];
  List<Tab> _tabs = [];
  TabController _tabController;

  List<Widget> getWidgets() {
    _todoWidgets.clear();
    for (int i = 0; i < _tabs.length; i++) {
      _todoWidgets.add(TodoList('title: $i'));
    }
    return _todoWidgets;
  }

  List<Tab> getTabs(List<TodoFilter> filters) {
    _tabs.clear();
    for (TodoFilter f in filters) {
      _tabs.add(Tab(text: "${f.title}"));
    }
    return _tabs;
  }

  TabController getTabController() {
    return TabController(length: _tabs.length, vsync: this);
  }

  void _addAnotherTab(List<TodoFilter> filters) {
    _tabs = getTabs(filters);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _removeTab(List<TodoFilter> filters) {
    _tabs = getTabs(filters);
    _tabController.index = 0;
    _tabController = getTabController();
    _updatePage();
  }

  void _updatePage() {
    setState(() {});
  }

  @override
  void initState() {
    _tabs = getTabs(Provider.of<FiltersNotifier>(context, listen: false).itemsFilter);
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var filters = Provider.of<FiltersNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("TODO リスト"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              String result = await showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AddFilterDialog();
                },
              );
              filters.createNewFilter(
                TodoFilter(
                  id: DateTime.now().toString(),
                  title: result,
                ),
              );
              var f = filters.itemsFilter.last;
              print("test: ${f.title}");
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () => _removeTab(filters.itemsFilter),
          ),
        ],
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: getWidgets(),
      ),
      //floatingActionButton: FloatingActionButton(),
    );
  }
}
