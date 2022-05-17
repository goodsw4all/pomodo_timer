import 'package:flutter/material.dart';

import 'widgets/dev_widgets.dart';

class PomodoroInfo extends StatelessWidget {
  const PomodoroInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: const [
            Text("Pomodoro Technique", style: TextStyle(fontSize: 25)),
            Text("(From Wikipedia, the free encyclopedia)",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 25,
            ),
            Text(
              """1. Decide on the task to be done.
              
2. Set the pomodoro timer (typically for 25 minutes).

3. Work on the task.

4. End work when the timer rings and take a short break (typically 5–10 minutes).

5. If you have finished fewer than three pomodoros, go back to Step 2 and repeat until you go through all three pomodoros.

6. After three pomodoros are done, take the fourth pomodoro and then take a long break (typically 20 to 30 minutes). Once the long break is finished, return to step 2.""",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
/*
From Wikipedia, the free encyclopedia
Jump to navigationJump to search
A tomato-shaped Pomodoro kitchen timer
A Pomodoro kitchen timer, after which the method is named.
The Pomodoro Technique is a time management method developed by Francesco Cirillo in the late 1980s.[1] It uses a timer to break work into intervals, typically 25 minutes in length, separated by short breaks. Each interval is known as a pomodoro, from the Italian word for tomato, after the tomato-shaped kitchen timer Cirillo used as a university student.[2][3]
 */
