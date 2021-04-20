import 'package:flutter/material.dart';
import 'package:sqflite/sql.dart';
import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/util.dart';

class TaskRepository with ChangeNotifier {
  static String table = 'task';
  static DBProvider instance = DBProvider.instance;
  List<Task> tasklist = [];

  List<Task> get task_items => tasklist;

  Future<Task> create(Task task) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'description': task.description,
      'is_checked': UtilTool.changeBooltoInt(task.is_checked),
      'is_enabled': UtilTool.changeBooltoInt(task.is_enabled),
      'timer': task.timer.toString(),
      'todo_id': task.todo_id,
      'created_at': now.toString(),
      'updated_at': now.toString(),
    };

    final db = await instance.database;
    final id = await db.insert(
      table,
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    Task _task = Task(
      id: id,
      description: row['description'],
      is_checked: UtilTool.changeInttoBool(row['is_checked']),
      is_enabled: UtilTool.changeInttoBool(row['is_enabled']),
      timer: row['timer'] as DateTime,
      todo_id: row['todo_id'],
      createdAt: row['createdAt'] as DateTime,
      updatedAt: row['updatedAt'] as DateTime,
    );

    notifyListeners();
    return _task;
  }

  Future<List<Task>> getTasks(int todo_id) async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table WHERE todo_id = ?', [todo_id]);
    if (rows.isEmpty) return null;
    final tasklist = rows.map((e) => Task.fromMap(e)).toList();
    this.tasklist = tasklist;

    notifyListeners();
    return tasklist;
  }

  Future<Task> single(int id) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE id = ?', [id]);
    if (rows.isEmpty) return null;

    return Task.fromMap(rows.first);
  }

  static Future<int> update({int id, String text}) async {
    String now = DateTime.now().toString();
    final row = {
      'id': id,
      'description': text,
      'updated_at': now,
    };
    final db = await instance.database;
    return db.update(
      table,
      row,
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static void deleteTasks(Todo todo) async {
    final db = await instance.database;
    await db.delete(table, where: 'todo_id = ?', whereArgs: [todo.id]);
  }
}
