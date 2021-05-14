import 'package:flutter/material.dart';
import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository with ChangeNotifier {
  static String table = 'todo';
  static DBProvider instance = DBProvider.instance;
  List<Todo> _todolist = [];

  List<Todo> get todoItems => _todolist;

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
    _todolist.insert(0, todo);
    notifyListeners();
    return todo;
  }

  Future<List<Todo>> getAll() async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table ORDER BY updated_at DESC');
    if (rows.isEmpty) return null;
    final t = rows.map((e) => Todo.fromMap(e)).toList();

    _todolist = t;

    notifyListeners();
    return _todolist;
  }

  Future<void> update(Todo _todo) async {
    String now = DateTime.now().toString();
    final row = {
      'id': _todo.id,
      'description': _todo.description,
      'updated_at': now,
    };
    final db = await instance.database;
    await db.update(table, row, where: 'id = ?', whereArgs: [_todo.id]);

    _todolist.asMap().forEach((i, v) {
      if (v.id == _todo.id) {
        this._todolist[i] = _todo;
      }
    });
    notifyListeners();
  }

  Future<void> delete(Todo _todo) async {
    final db = await instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: [_todo.id]);

    _todolist.remove(_todo);
    notifyListeners();
  }
}
