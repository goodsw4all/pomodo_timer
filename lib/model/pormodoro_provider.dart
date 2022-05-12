import 'package:flutter/material.dart';
import 'package:pomodoro/db/pomodoro_db.dart';

import 'pomodoro_setting.dart';

class PomodoroCompleteTask {
  final String name;
  final String category;
  bool isDone = false;

  PomodoroCompleteTask(
      {required this.name, this.category = "General", this.isDone = false});
}

class PomodoroProvider with ChangeNotifier {
  List<PomodoroCompleteTask> _tasks = [];

  PomodoroProvider() {
    print("PomodoroProvider()");

    initSchedule();
  }

  Future<void> initSchedule() async {
    // await PomodoroSetting.loadSharedPref();

    // print("PomodoroProvider() $temp");
    // if (temp == 0)
    //   tasks.clear();
    // else {
    //   for (var i = 0; i < temp; i++) {
    //     _tasks.add(PomodoroCompleteTask(name: "Good Job", isDone: true));
    //   }
    // }
  }

  List<PomodoroCompleteTask> get tasks {
    return _tasks;
  }

  void addTaskComplete(PomodoroCompleteTask task) {
    _tasks.add(task);
    print(_tasks.length);
    // PomodoroSetting.increasePomodoroTaskData();
    // TODO: SQL Insert or Update

    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    // PomodoroSetting.resetTaskData();
    notifyListeners();
  }
}
