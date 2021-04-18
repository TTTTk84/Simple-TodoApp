import 'package:sqflite/sqlite_api.dart';

class Query {
  final String foreigin_query = 'PRAGMA foreign_keys = ON';

  final String todo_query = '''
  CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
    );
  ''';

  final String task_query = '''
  CREATE TABLE task(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT NOT NULL,
      is_checked INTEGER NOT NULL,
      is_enabled INTEGER NOT NULL,
      timer TEXT NOT NULL,
      todo_id INTEGER NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
  );
  ''';

  final insert_query = '''
  INSERT INTO todo(description,created_at,updated_at)
    values('todo1','${DateTime.now().toString()}','${DateTime.now().toString()}'),
          ('todo2','${DateTime.now().toString()}','${DateTime.now().toString()}'),
          ('todo3','${DateTime.now().toString()}','${DateTime.now().toString()}');
  ''';

  onCreate(Database db, int version) async {
    await db.execute("${todo_query}");
    await db.execute("${task_query}");
    await db.execute("${insert_query}");
  }

  onConfigure(Database db) async {
    await db.execute("${foreigin_query}");
  }
}

//
