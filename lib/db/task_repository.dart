import 'package:sqflite/sql.dart';
import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/todo.dart';

class TaskRepository {
  static String table = 'task';
  static DBProvider instance = DBProvider.instance;

  static Future<Task> create(Task task) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'description': task.description,
      'is_checked': task.is_checked,
      'is_enabled': task.is_enabled,
      'timer': task.timer,
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

    return Task(
      id: id,
      description: row['description'],
      is_checked: row['is_checked'],
      is_enabled: row['is_enabled'],
      timer: row['timer'],
      todo_id: row['todo_id'],
      createdAt: row['createdAt'],
      updatedAt: row['updatedAt'],
    );
  }

  static Future<List<Task>> getAll() async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table ORDER BY updated_at DESC');
    if (rows.isEmpty) return null;

    return rows.map((e) => Task.fromMap(e)).toList();
  }

  static Future<Task> single(int id) async {
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
