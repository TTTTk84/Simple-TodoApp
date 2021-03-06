import 'package:flutter/material.dart';
import 'package:todo_app/utils/util.dart';

class Task {
  Task({
    @required this.id,
    @required this.description,
    @required this.is_checked = false,
    @required this.is_enabled = false,
    @required this.timer,
    @required this.todo_id,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String description;
  bool is_checked;
  bool is_enabled;
  DateTime timer;
  int todo_id;
  DateTime createdAt;
  DateTime updatedAt;

  factory Task.useSql(Map<String, dynamic> json) => Task(
        id: json['id'],
        description: json['description'],
        is_checked: UtilTool.changeInttoBool(json['is_checked']),
        is_enabled: UtilTool.changeInttoBool(json['is_enabled']),
        timer: DateTime.tryParse(json['timer'].toString()),
        todo_id: json['todo_id'],
        createdAt: DateTime.tryParse(json['createdAt'].toString()),
        updatedAt: DateTime.tryParse(json['updatedAt'].toString()),
      );

  factory Task.useModal(Map<String, dynamic> json) => Task(
        id: json['id'],
        description: json['description'],
        is_checked: json['is_checked'],
        is_enabled: json['is_enabled'],
        timer: json['timer'],
        todo_id: json['todo_id'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
