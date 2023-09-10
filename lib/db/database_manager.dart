import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  Database? _db;

  DatabaseManager._();

  static DatabaseManager instance = DatabaseManager._();

  Future<Database> get db async {
    _db ??= await initDB();
    return _db!;
  }

  Future initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();

    String path = join(docDir.path, "expenses.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async =>
          await db.execute('''CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        uuid TEXT NOT NULL,
        title TEXT NOT NULL,
        amount INTEGER NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )'''),
    );
  }

  Future closeDB() async {
    _db = await instance.db;
    _db?.close();
  }
}
