import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/db/query.dart';

class DBProvider {
  final _databaseName = "MyDatabase.db";
  final _databaseVersion = 1;

  DBProvider._();
  static final DBProvider instance = DBProvider._();

  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, _databaseName);
    print('dbpath: ${path}');
    return await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: Query().onConfigure,
      onCreate: Query().onCreate,
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }
}
