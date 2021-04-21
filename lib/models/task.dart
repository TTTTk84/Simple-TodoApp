import 'package:flutter/material.dart';
import 'package:todo_app/util.dart';

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

  final int id;
  String description;
  bool is_checked;
  bool is_enabled;
  DateTime timer;
  final int todo_id;
  final DateTime createdAt;
  DateTime updatedAt;

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        id: json['id'],
        description: json['description'],
        is_checked: UtilTool.changeInttoBool(json['is_checked']),
        is_enabled: UtilTool.changeInttoBool(json['is_enabled']),
        timer: DateTime.tryParse(json['timer'].toString()),
        todo_id: json['todo_id'],
        createdAt: DateTime.tryParse(json['createdAt'].toString()),
        updatedAt: DateTime.tryParse(json['updatedAt'].toString()),
      );
}
