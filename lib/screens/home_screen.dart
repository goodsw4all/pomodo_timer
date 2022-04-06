import 'package:flutter/material.dart';
import 'package:pomodoro/model/time_space.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../model/pormodoro_provider.dart';
import 'pomodoro_page.dart';
import 'info_page.dart';
import 'setting_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIdx = 0;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages.add(const PomodoroTimerPage());
    pages.add(SettingPage());
    pages.add(PomodoroInfo());

    initSchedule();
  }

  Future<void> initSchedule() async {
    // await PomodoroData.loadSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIdx,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIdx,
        // iconSize: 35,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarms),
            label: 'Pomodoro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIdx = index;
    });
  }

  @override
  void dispose() {
    print("-> $runtimeType Dispose");
    super.dispose();
  }
}
