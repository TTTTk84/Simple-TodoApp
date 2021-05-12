import 'package:flutter/material.dart';
import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository with ChangeNotifier {
  static String table = 'todo';
  static DBProvider instance = DBProvider.instance;
  List<Todo> todolist = [];

  List<Todo> get todoItems => todolist;

  Future<Todo> create(String text) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'description': text,
      'created_at': now.toString(),
      'updated_at': now.toString(),
    };
    final db = await instance.database;
    final id = await db.insert(table, row);
    if (id == 0) return null;
    Todo todo = Todo.fromMap(row);
    todo.id = id;
    this.todolist.insert(0, todo);
    notifyListeners();
    return todo;
  }

  Future<List<Todo>> getAll() async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table ORDER BY updated_at DESC');
    if (rows.isEmpty) return null;
    final todolist = rows.map((e) => Todo.fromMap(e)).toList();

    this.todolist = todolist;

    notifyListeners();
    return todolist;
  }

  Future<void> update(Todo todo) async {
    String now = DateTime.now().toString();
    final row = {
      'id': todo.id,
      'description': todo.description,
      'updated_at': now,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [todo.id]);

    var _todolist = this.todolist;
    _todolist.asMap().forEach((i, v) {
      if (v.id == todo.id) {
        this.todolist[i] = todo;
      }
    });
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    final db = await instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: [todo.id]);

    this.todolist.remove(todo);
    notifyListeners();
  }
}
