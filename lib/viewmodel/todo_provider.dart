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

  int searchTodoIndex(Todo todo) {
    int index = _toDoList.indexWhere((t) => t.uuid == todo.uuid);
    return index;
  }

  int searchTaskIndex(Todo todo, Task task) {
    int todo_index = searchTodoIndex(todo);
    int task_index =
        _toDoList[todo_index].tasks.indexWhere((t) => t.uuid == task.uuid);
    return task_index;
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

  void createNewTask(Todo todo, String task_description) {
    final newtask =
        Task(task: task_description, uuid: DateTime.now().toString());
    int index = searchTodoIndex(todo);
    _toDoList[index].tasks.add(newtask);
    notifyListeners();
  }

  void checkedTask(Todo todo, Task task) {
    int todo_index = searchTodoIndex(todo);
    int task_index = searchTaskIndex(todo, task);
    _toDoList[todo_index].tasks[task_index].is_checked =
        !_toDoList[todo_index].tasks[task_index].is_checked;
    notifyListeners();
  }
}