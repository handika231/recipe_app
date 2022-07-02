import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  //private constructor
  static DatabaseManager instance = DatabaseManager._();
  DatabaseManager._();

  //Membuat Database
  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'recipe.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    return await db.execute(
      '''
        CREATE TABLE recipes (
          id INTEGER PRIMARY KEY,
          title TEXT,
          content TEXT,
          image TEXT
          )''',
    );
  }

  Future closeDB() async {
    _database = await instance.database;
    _database!.close();
  }
}
