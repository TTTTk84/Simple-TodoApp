import 'package:todo_app/models/todo.dart';
import 'package:flutter/cupertino.dart';

class TodoFilter with ChangeNotifier {
  final String id;
  String title;

  List<Todo> _toDoList = [];

  TodoFilter({this.id, this.title});

  List<Todo> get itemsList {
    return _toDoList;
  }

  void createNewTodo(Todo todo) {
    final newtodo = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
    );
    _toDoList.add(newtodo);
    notifyListeners();
  }

  void changeStatus(String id) {
    int i = _toDoList.indexWhere((e) => e.id == id);
    _toDoList[i].isCheckd = !_toDoList[i].isCheckd;
  }

  void removeFilter(String id) {
    int i = _toDoList.indexWhere((e) => e.id == id);
    _toDoList.removeAt(i);
  }
}
