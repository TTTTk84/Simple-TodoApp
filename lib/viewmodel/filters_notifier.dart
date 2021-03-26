import 'package:provider/provider.dart';
import 'package:todo_app/models/todofilter.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class FiltersNotifier with ChangeNotifier {
  final int _limitCount = 4;

  List<TodoFilter> _toDoFilters = [
    TodoFilter(
      id: "filter#1",
      title: "筋トレ",
    ),
    TodoFilter(
      id: "filter#2",
      title: "勉強",
    ),
  ];

  List<TodoFilter> get itemsFilter {
    return _toDoFilters;
  }

  int get itemsLength {
    return _toDoFilters.length;
  }

  StreamController<String> _currentFilterController =
      StreamController<String>();

  Stream<String> get getfilters => _currentFilterController.stream;

  void createNewFilter(TodoFilter todofilter) {
    final newfil = TodoFilter(
      id: todofilter.id,
      title: todofilter.title,
    );
    _toDoFilters.add(newfil);
    notifyListeners();
  }

  void removeFilter(String id) {
    int i = _toDoFilters.indexWhere((e) => e.id == id);
    _toDoFilters.removeAt(i);
  }
}
