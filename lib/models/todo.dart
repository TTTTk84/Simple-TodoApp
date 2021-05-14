import 'package:flutter/material.dart';

class Todo {
  Todo({
    @required this.id,
    @required this.description,
    @required this.createdAt,
    @required this.updatedAt,
  });

  int id;
  String description;
  final DateTime createdAt;
  DateTime updatedAt;

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json['id'],
        description: json['description'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
