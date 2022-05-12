import 'package:shared_preferences/shared_preferences.dart';

class PomodoroSetting {
  static Map<String, int> workSchedule = {
    "INITIALIZED": 1,
    "WORK": 25,
    "LONG_BREAK": 15,
    "BREAK": 5,
  };

  static var prefs = null;

  // static initPomodoroScheduleSetting() async {
  //   prefs = await SharedPreferences.getInstance();
  // }

  static Future<void> loadSharedPref() async {
    // final today = DateTime.now().toString().split(' ')[0];
    // await prefs.clear();
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    int? inited = prefs.getInt("INITIALIZED");
    if (inited == null || inited == 0) {
      print("There is no key, I need to initialize 👍");
      for (var item in workSchedule.entries) {
        await prefs.setInt(item.key, item.value);
      }
    } else {
      print("Loading prefs");
      for (var key in workSchedule.keys) {
        int? temp = prefs.getInt(key);
        workSchedule[key] = temp!;
        // print("\t$key, ${temp}");
      }
      PomodoroSetting.workSchedule.forEach((key, value) {
        print(key);
        print(value);
      });
    }
  }

  static int getScheduleValue(String key) {
    return prefs.getInt(key);
  }

  static modifyDurationData(String key, int value) async {
    // final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    workSchedule[key] = value;
  }

  static Future<void> resetPomodoroData() async {
    // final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("INITIALIZED", 0);
  }

  static Future<void> increasePomodoroTaskData() async {
    // final prefs = await SharedPreferences.getInstance();
    // TODO : SQL insert
  }

  static Future<void> resetTaskData() async {
    // final prefs = await SharedPreferences.getInstance();
  }
}
