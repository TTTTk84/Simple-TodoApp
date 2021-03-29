import 'package:flutter/cupertino.dart';
import 'package:todo_app/models/task.dart';

class Todo {
  final String uuid;
  String description;
  List<Task> tasks;

  Todo({
    this.uuid,
    this.description,
    this.tasks,
  });
}
