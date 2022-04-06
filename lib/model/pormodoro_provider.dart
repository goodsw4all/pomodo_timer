import 'package:flutter/material.dart';

import 'time_space.dart';

class PomodoroTask {
  final String name;
  final String category;
  bool isDone = false;

  PomodoroTask(
      {required this.name, this.category = "General", this.isDone = false});
}

class PomodoroProvider with ChangeNotifier {
  List<PomodoroTask> _tasks = [];

  PomodoroProvider() {
    print("PomodoroProvider()");

    initSchedule();
  }
  Future<void> initSchedule() async {
    await PomodoroData.loadSharedPref();
    print("PomodoroProvider ${PomodoroData.schedule}");
    print("PomodoroProvider ${PomodoroData.tasks_record}");
    int temp = int.parse(PomodoroData.tasks_record["DATE"]![1]);
    print("PomodoroProvider() $temp");
    if (temp == 0)
      tasks.clear();
    else {
      for (var i = 0; i < temp; i++) {
        _tasks.add(PomodoroTask(name: "Good Job", isDone: true));
      }
    }
  }

  List<PomodoroTask> get tasks {
    return _tasks;
  }

  void addTaskComplete(PomodoroTask task) {
    _tasks.add(task);
    print(_tasks.length);
    PomodoroData.increasePomodoroTaskData();
    notifyListeners();
  }

  void clearTasks() {
    _tasks.clear();
    PomodoroData.resetTaskData();
    notifyListeners();
  }
}
