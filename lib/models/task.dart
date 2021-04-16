import 'package:flutter/material.dart';

class Task {
  Task({
    @required this.id,
    @required this.description,
    @required this.is_checked,
    @required this.is_enabled,
    @required this.timer,
    @required this.todo_id,
    @required this.createdAt,
    @required this.updatedAt,
  });

  final int id;
  final String description;
  final bool is_checked;
  final bool is_enabled;
  final DateTime timer;
  final int todo_id;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Task.fromMap(Map<String, dynamic> json) => Task(
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
