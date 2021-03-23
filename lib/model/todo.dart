import 'package:flutter/cupertino.dart';

class Todo {
  final String id;
  String description;
  bool isCheckd;

  Todo({this.id, this.description, this.isCheckd = false});
}

class TodoProvider with ChangeNotifier {
  List<Todo> _toDoList = [
    Todo(
      id: 'task#1',
      description: 'task1',
    ),
    Todo(
      id: 'task#2',
      description: 'task2',
    ),
  ];

  List<Todo> get itemsList {
    return _toDoList;
  }

  void createNewTodo(Todo todo) {
    final newtodo = Todo(
      id: todo.id,
      description: todo.description,
    );
    _toDoList.add(newtodo);
    print('_toDoList: ${_toDoList}');
    notifyListeners();
  }

  void changeStatus(String id) {
    int index = _toDoList.indexWhere((todo) => todo.id == id);
    _toDoList[index].isCheckd = !_toDoList[index].isCheckd;
  }

  void removeTodo(String id) {
    int index = _toDoList.indexWhere((todo) => todo.id == id);
    _toDoList.removeAt(index);
  }
}
