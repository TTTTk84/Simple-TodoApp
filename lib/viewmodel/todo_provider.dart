import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:flutter/cupertino.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _toDoList = [
    Todo(
      'todo#1',
      '筋トレ',
      [
        Task(uuid: "task#1", task: "腹筋"),
        Task(uuid: "task#2", task: "背筋"),
        Task(uuid: "task#3", task: "スクワット"),
      ],
    ),
    Todo(
      'todo#2',
      '勉強',
      [
        Task(uuid: "task#1", task: "国語"),
        Task(uuid: "task#2", task: "数学"),
      ],
    ),
  ];

  List<Todo> get itemsList {
    return _toDoList;
  }

  void createNewTodo(String description) {
    final newtodo = Todo(
      DateTime.now().toString(),
      description,
      [],
    );
    _toDoList.add(newtodo);
    notifyListeners();
  }

  // void changeStatus(String id) {
  //   int index = _toDoList.indexWhere((todo) => todo.uuid == id);
  //   _toDoList[index].isCheckd = !_toDoList[index].isCheckd;
  // }
}
