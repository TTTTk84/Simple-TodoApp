import 'package:flutter/material.dart';
import 'package:sqflite/sql.dart';
import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utils/util.dart';

class TaskRepository with ChangeNotifier {
  static String table = 'task';
  static DBProvider instance = DBProvider.instance;
  List<Task> tasklist = [];
  List<Task> enabledTask = [];

  List<Task> get taskItems => tasklist;
  List<Task> get enabledTaskItems => enabledTask;

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
    Task _task = Task.useSql(row);
    _task.id = id;
    this.tasklist.add(_task);
    notifyListeners();
    return _task;
  }

  Future<List<Task>> getTasks(int todoId) async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table WHERE todo_id = ?', [todoId]);
    if (rows.isEmpty) return null;
    final tasklist = rows.map((e) => Task.useSql(e)).toList();
    this.tasklist = tasklist;

    notifyListeners();
    return tasklist;
  }

  Future<void> changeCheck(Task task) async {
    final row = {
      'is_checked': !task.is_checked,
    };
    final db = await instance.database;
    await db.update(
      table,
      row,
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    var _tasklist = this.tasklist;
    _tasklist.asMap().forEach((i, v) {
      if (v.id == task.id) {
        this.tasklist[i].is_checked = !task.is_checked;
      }
    });
    notifyListeners();
  }

  Future<void> delete(Task task) async {
    final db = await instance.database;
    await db.delete(table, where: 'id = ?', whereArgs: [task.id]);
    this.tasklist.remove(task);
    notifyListeners();
  }

  Future<void> update(Task task) async {
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
    await db.update(
      table,
      row,
      where: 'id = ?',
      whereArgs: [task.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    var _tasklist = this.tasklist;
    _tasklist.asMap().forEach((i, v) {
      if (v.id == task.id) {
        this.tasklist[i] = task;
      }
    });
    notifyListeners();
  }

  Future<void> deleteTasks(Todo todo) async {
    final db = await instance.database;
    await db.delete(table, where: 'todo_id = ?', whereArgs: [todo.id]);
  }

  Future<List<Task>> getReminderTask() async {
    final db = await instance.database;
    final rows = await db.rawQuery(
        'SELECT * FROM $table WHERE is_enabled = ? AND is_checked = ?', [1, 0]);
    if (rows.isEmpty) return null;
    final tasklist = rows.map((e) => Task.useSql(e)).toList();
    this.enabledTask = tasklist;

    notifyListeners();
    return tasklist;
  }

  Future<void> refresh() async {
    this.tasklist.removeRange(0, this.tasklist.length);
    notifyListeners();
  }
}
