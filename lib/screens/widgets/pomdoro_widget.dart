import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../model/pomodoro_setting.dart';
import '../../model/pormodoro_provider.dart';
import 'timer_control_button_widget.dart';

class PomodoroWidget extends StatefulWidget {
  const PomodoroWidget({Key? key}) : super(key: key);

  @override
  State<PomodoroWidget> createState() => _PomodoroWidgetState();
}

class _PomodoroWidgetState extends State<PomodoroWidget> {
  late StopWatchTimer _stopWatchTimer;
  late AudioPlayer player;
  final GlobalKey _widgetKey = GlobalKey();

  Future<void> playSoundEffect(String type) async {
    Map<String, String> soundType = {
      "Start": "assets/audio/CameraFocus.wav",
      "Reset": "assets/audio/Lock.wav",
      "Almost": "assets/audio/cowbell.mp3",
      "End": "assets/audio/Scandium.wav",
    };

    await player.setAsset(soundType[type]!);
    await player.play();
  }

  @override
  void initState() {
    var default_time = 0;
    super.initState();

    player = AudioPlayer();

    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(default_time),
      onEnded: () {
        playSoundEffect('End');
        // Provider.of<PomodoroProvider>(context, listen: false)
        //     .addTaskComplete(PomodoroTask(name: "Good Job"));

        Future.delayed(const Duration(milliseconds: 2000), () {
          playSoundEffect('Reset');
          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);

          context
              .read<PomodoroProvider>()
              .addTaskComplete(PomodoroCompleteTask(name: "Good Job"));
        });
      },
    );
  }

  @override
  void dispose() {
    print('dispose pomodoro timer');
    player.dispose();
    super.dispose();
  }

  double _getWidgetInfo() {
    final keyContext = _widgetKey.currentContext;
    if (keyContext != null) {
      // widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      final pos = box.localToGlobal(Offset.zero);
      print(box.size);
      return box.size.height;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = 0;
    _stopWatchTimer.clearPresetTime();
    print(_stopWatchTimer);
    _stopWatchTimer
        .setPresetMinuteTime(PomodoroSetting.getScheduleValue("WORK"));
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        // Tomato Image
        Container(
          key: _widgetKey,
          padding: EdgeInsets.only(left: 40, right: 40, top: 10),
          child: Image.asset(
            'assets/images/tomato.png',
            scale: 1.8,
            // fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 50,
          child: Column(
            children: [
              // widget.timer,
              Container(
                padding: const EdgeInsets.only(bottom: 3),
                alignment: Alignment.bottomCenter,
                child: StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime = StopWatchTimer.getDisplayTime(value,
                        hours: false, milliSecond: false);
                    return Column(
                      children: <Widget>[
                        Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 33,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                // Buttons for timer control
                padding: const EdgeInsets.only(top: 5, left: 100, right: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerControlButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressHandler: () {
                        print(
                            '_stopWatchTimer.isRunning ${_stopWatchTimer.isRunning}');
                        if (!_stopWatchTimer.isRunning &&
                            _stopWatchTimer.rawTime.value > 0) {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        }

                        SystemSound.play(SystemSoundType.click);
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TimerControlButton(
                      icon: const Icon(Icons.pause),
                      onPressHandler: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        SystemSound.play(SystemSoundType.click);
                      },
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TimerControlButton(
                      icon: const Icon(Icons.refresh),
                      onPressHandler: () {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        SystemSound.play(SystemSoundType.click);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
