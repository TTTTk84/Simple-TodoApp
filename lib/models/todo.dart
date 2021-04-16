import 'package:flutter/material.dart';

class Todo {
  Todo({
    @required this.id,
    @required this.description,
    @required this.createdAt,
    @required this.updatedAt,
  })  : assert(id != null),
        assert(description != null),
        assert(createdAt != null),
        assert(updatedAt != null);

  final int id;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Todo.fromMap(Map<String, dynamic> json) => Todo(
        id: json['id'],
        description: json['description'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
      );
}
