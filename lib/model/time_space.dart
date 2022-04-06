import 'package:shared_preferences/shared_preferences.dart';

class PomodoroData {
  static Map<String, int> schedule = {
    "INITIALIZED": 0,
    "WORK": 25,
    "LONG_BREAK": 15,
    "SHORT_BREAK": 5,
  };

  static var tasks_record = {
    "DATE": ["2022-04-01", "0"],
  };

  static Future<void> loadSharedPref() async {
    final today = DateTime.now().toString().split(' ')[0];

    final prefs = await SharedPreferences.getInstance();

    var keys = prefs.getKeys();
    int? inited = prefs.getInt("INITIALIZED");
    if (inited == null || inited == 0) {
      print("There is no key, I need to initialize 👍");
      for (var item in schedule.entries) {
        await prefs.setInt(item.key, item.value);
      }
      await prefs.setStringList("DATE", tasks_record["DATE"]!);
    } else {
      print("Loading prefs");
      for (var key in schedule.keys) {
        int? temp = prefs.getInt(key);
        schedule[key] = temp!;
      }
      // print(tasks_record["DATE"]![0]);
      // print(today);

      tasks_record["DATE"] = prefs.getStringList(tasks_record.keys.first)!;
      if (tasks_record["DATE"]![0] != today) {
        print(tasks_record["DATE"]![0]);
        print(today);
        tasks_record["DATE"]![0] = today;
        tasks_record["DATE"]![1] = "0";

        await prefs.setStringList("DATE", tasks_record["DATE"]!);
      }
    }
  }

  static modifyDurationData(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    schedule[key] = value;
  }

  static Future<void> resetPomodoroData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("INITIALIZED", 0);
  }

  static Future<void> increasePomodoroTaskData() async {
    final prefs = await SharedPreferences.getInstance();

    int temp = int.parse(PomodoroData.tasks_record["DATE"]![1]);
    temp += 1;
    tasks_record["DATE"]![1] = temp.toString();
    await prefs.setStringList("DATE", tasks_record["DATE"]!);

    print(prefs.getStringList(tasks_record.keys.first)!);
  }

  static Future<void> resetTaskData() async {
    final prefs = await SharedPreferences.getInstance();

    // tasks_record["DATE"]![0] = today;
    tasks_record["DATE"]![1] = "0";

    await prefs.setStringList("DATE", tasks_record["DATE"]!);
  }
}
