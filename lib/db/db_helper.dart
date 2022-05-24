import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DbHelper {
  static Database? db;
  static const int version = 1;
  static const String dbName = 'Storage.db';
  static const String tableName = 'tasks';

  Future<void> initializeDb() async {
    if (db != null) {
      return;
    } else {
      String path = await getDatabasesPath() + dbName;
      db = await openDatabase(path, version: version, onCreate: (db, version) async {
        print('creating new db');
        await db.execute('''
          CREATE TABLE 'tasks'(
            'id' INTEGER PRIMARY KEY AUTOINCREMENT,
            'title' STRING,
            'note' STRING,
            'date' STRING,
            'startTime' STRING,
            'endTime' STRING,
            'color' INTEGER,
            'remind' INTEGER,
            'repeat' STRING,
            'isCompleted' INTEGER
          );
        ''');
      });
    }
  }
  
  insert(Task? task) async {
    if(db!=null){
      return await db?.insert(tableName, task!.listToMap());
    }
  }

  Future<List<Map<String,dynamic>>> getTasks() async{
    return await db!.query(tableName);
  }

  delete(Task? task) async {
    return await db?.delete(tableName,where: 'id=?',whereArgs: [task!.id]);
  }

  update(Task? task) async{
    return await db?.update(tableName, task!.listToMap(),where: 'id=?',whereArgs: [task.id]);
  }
}
