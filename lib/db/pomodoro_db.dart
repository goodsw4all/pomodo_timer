import 'dart:async';

import 'package:path/path.dart';
import 'package:pomodoro/model/pomodoro_model.dart';
import 'package:sqflite/sqflite.dart';

class PomodoroDB {
  static final PomodoroDB instance = PomodoroDB._init();

  static Database? _database;

  PomodoroDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('pomodoro.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName ( 
      ${PomodoroFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PomodoroFields.date} TEXT NOT NULL,
      ${PomodoroFields.work_time} INTEGER NOT NULL,
      ${PomodoroFields.break_long_time} INTEGER NOT NULL,
      ${PomodoroFields.break_short_time} INTEGER NOT NULL,
      ${PomodoroFields.task} TEXT NOT NULL,
      ${PomodoroFields.category} TEXT NOT NULL,
      ${PomodoroFields.task_count} INTEGER NOT NULL
    )
    ''');
  }

  Future<PomodoroTask> insert(PomodoroTask task) async {
    final db = await instance.database;

    var id = await db.insert(tableName, task.toJson());
    task.id = id;
    return task;
  }

  Future<PomodoroTask?> getData(int id) async {
    final db = await instance.database;
    var maps = await db.query(tableName,
        columns: PomodoroFields.values,
        where: '${PomodoroFields.id} = ?',
        whereArgs: [
          id,
        ]);
    if (maps.isNotEmpty) {
      print('Got data from  getData');
      return PomodoroTask.fromJson(maps.first);
    } else {
      print('ID not found');
      return null;
    }
  }

  Future<List<PomodoroTask?>> getAllData() async {
    final db = await instance.database;
    var result = await db.query(
      tableName,
      orderBy: "${PomodoroFields.id} ASC",
    );

    return result.map((json) => PomodoroTask.fromJson(json)).toList();
  }

  Future<int> update(PomodoroTask task) async {
    final db = await instance.database;

    return db.update(
      tableName,
      task.toJson(),
      where: '${PomodoroFields.date} = ?',
      whereArgs: [task.date],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
