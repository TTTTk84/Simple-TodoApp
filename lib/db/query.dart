import 'package:sqflite/sqlite_api.dart';

class Query {
  static final String now = DateTime.now().toString();
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

  final String insert_todo_query = '''
  INSERT INTO todo(description,created_at,updated_at)
    values('学校','$now','$now'),
          ('筋トレ','$now','$now');
  ''';

  final insert_task_query = '''
  INSERT INTO task(description,is_checked,is_enabled,timer,todo_id,created_at,updated_at)
    values('国語プリント', 0, 0, '$now', 1, '$now', '$now'),
          ('数学プリント', 0, 0, '$now', 1, '$now', '$now'),
          ('英語プリント', 0, 0, '$now', 1, '$now', '$now'),
          ('腹筋', 0, 0, '$now', 2, '$now', '$now'),
          ('背筋', 0, 0, '$now', 2, '$now', '$now');
  ''';

  onCreate(Database db, int version) async {
    await db.execute("${todo_query}");
    await db.execute("${task_query}");
    await db.execute("${insert_todo_query}");
    await db.execute("${insert_task_query}");
  }

  onConfigure(Database db) async {
    await db.execute("${foreigin_query}");
  }
}
