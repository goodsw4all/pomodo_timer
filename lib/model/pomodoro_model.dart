// To parse this JSON data, do
//
//     final pomodoro = pomodoroFromJson(jsonString);

import 'dart:convert';

PomodoroTask pomodoroFromJson(String str) =>
    PomodoroTask.fromJson(json.decode(str));

String pomodoroToJson(PomodoroTask data) => json.encode(data.toJson());

const String tableName = 'pomodoro_record';

class PomodoroFields {
  static final List<String> values = [
    /// Add all fields
    date, work_time, break_long_time, break_short_time, task, category,
    task_count,
  ];

  static var id = "_id";
  static const String date = "date";
  static const String work_time = "work_time";
  static const String break_long_time = "break_long_time";
  static const String break_short_time = "break_short_time";
  static const String task = "task";
  static const String category = "category";
  static const String task_count = "task_count";
}

class PomodoroTask {
  PomodoroTask({
    this.id,
    required this.date,
    this.workTime = 25,
    this.breakLongTime = 15,
    this.breakShortTime = 5,
    this.task = "N/A",
    this.category = "N/A",
    this.taskCount = 0,
  });

  String date;
  int? id;
  int workTime;
  int breakLongTime;
  int breakShortTime;
  String task;
  String category;
  int taskCount;

  factory PomodoroTask.fromJson(Map<String, dynamic> json) => PomodoroTask(
        id: json["_id"] as int?,
        date: json["date"],
        workTime: json["work_time"],
        breakLongTime: json["break_long_time"],
        breakShortTime: json["break_short_time"],
        task: json["task"],
        category: json["category"],
        taskCount: json["task_count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "date": date,
        "work_time": workTime,
        "break_long_time": breakLongTime,
        "break_short_time": breakShortTime,
        "task": task,
        "category": category,
        "task_count": taskCount,
      };
}
