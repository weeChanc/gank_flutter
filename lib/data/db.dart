import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

Database db;

void init() async {
  var databasesPath = await getDatabasesPath();
  String path = databasesPath + 'demo.db';
  db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Article (
            id INTEGER PRIMARY KEY AUTO INCREMENT, 
            title TEXT, 
            time TEXT, 
            type TEXT, 
            url TEXT,
            author TEXT)
          ''');
      });
}
