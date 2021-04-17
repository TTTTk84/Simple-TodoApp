import 'package:todo_app/db/db_provider.dart';
import 'package:todo_app/models/todo.dart';

class TodoRepository {
  static String table = 'todo';
  static DBProvider instance = DBProvider.instance;

  static Future<Todo> create(String text) async {
    DateTime now = DateTime.now();
    final Map<String, dynamic> row = {
      'description': text,
      'created_at': now.toString(),
      'updated_at': now.toString(),
    };
    final db = await instance.database;
    final id = await db.insert(table, row);
    print('id: ${id}');
    if (id == 0) return null;

    return Todo(
      id: id,
      description: row['description'],
      createdAt: now,
      updatedAt: now,
    );
  }

  static Future<List<Todo>> getAll() async {
    final db = await instance.database;
    final rows =
        await db.rawQuery('SELECT * FROM $table ORDER BY updated_at DESC');
    if (rows.isEmpty) return null;

    return rows.map((e) => Todo.fromMap(e)).toList();
  }

  static Future<Todo> single(int id) async {
    final db = await instance.database;
    final rows = await db.rawQuery('SELECT * FROM $table WHERE id = ?', [id]);
    if (rows.isEmpty) return null;

    return Todo.fromMap(rows.first);
  }

  static Future<int> update({int id, String text}) async {
    String now = DateTime.now().toString();
    final row = {
      'id': id,
      'description': text,
      'updated_at': now,
    };
    final db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
