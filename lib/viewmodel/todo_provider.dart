import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:flutter/cupertino.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _toDoList = [
    Todo(
      uuid: 'todo#1',
      description: '筋トレ',
      tasks: [
        Task(uuid: "task#1", task: "腹筋"),
        Task(uuid: "task#2", task: "背筋"),
        Task(uuid: "task#3", task: "スクワット"),
      ],
    ),
    Todo(
      uuid: 'todo#2',
      description: '勉強',
      tasks: [
        Task(uuid: "task#1", task: "国語"),
        Task(uuid: "task#2", task: "数学"),
      ],
    ),
  ];

  List<Todo> get itemsList {
    return _toDoList;
  }

  void createNewTodo(Todo todo) {
    final newtodo = Todo(
      uuid: DateTime.now().toString(),
      description: todo.description,
    );
    _toDoList.add(newtodo);
    print('_toDoList: ${_toDoList}');
    notifyListeners();
  }

  // void changeStatus(String id) {
  //   int index = _toDoList.indexWhere((todo) => todo.uuid == id);
  //   _toDoList[index].isCheckd = !_toDoList[index].isCheckd;
  // }
}
