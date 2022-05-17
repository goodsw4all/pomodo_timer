import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:pomodoro/model/pormodoro_provider.dart';
import 'package:pomodoro/screens/widgets/pomdoro_widget.dart';

class PomodoroTimerPage extends StatefulWidget {
  const PomodoroTimerPage({Key? key}) : super(key: key);

  @override
  State<PomodoroTimerPage> createState() => _PomodoroTimerPageState();
}

class _PomodoroTimerPageState extends State<PomodoroTimerPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  // var today_string = DateFormat('yyyy-MM-dd').format(DateTime.now() );
  var today_string =
      DateFormat('yyyy-MM-dd').format(DateTime.parse("2022-05-05"));

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      upperBound: 400.0,
      lowerBound: 380.0,
    );

    _animationController.forward();
    _animationController.addListener(() {
      setState(() {
        // print(controller.value);
      });
    });

    final periodicTimer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        if (today_string != getToday()) {
          print("change Date");
          setState(() {
            today_string = getToday();
          });
        }
      },
    );
  }

  String getToday() {
    return DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    print('dispose pomodoro timer');
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.read<PomodoroProvider>().initPomodoroProvider();

    var width = MediaQuery.of(context).size.width;
    print('$runtimeType : $width');

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.yellow,
            Colors.red,
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const PomodoroWidget(),
            SizedBox(
              height: 10,
            ),
            Text(
              today_string,
              style: const TextStyle(
                  fontSize: 33,
                  fontFamily: 'Helvetica',
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              'Make Today Great 👍',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.w400,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                // showBreakBottomSheet(context);
                context.read<PomodoroProvider>().clearTasks();
              },
              style: OutlinedButton.styleFrom(primary: Colors.white54),
              child: Text(
                "Clear pomodoros",
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 120,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  crossAxisCount: 8,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: _buildCompletePomodoros(context, 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCompletePomodoros(BuildContext context, int count) {
    var tasks = Provider.of<PomodoroProvider>(context).tasks;

    List<Widget> completedcount = [];
    for (int i = 0; i < tasks.length; i++) {
      completedcount.add(Container(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          'assets/images/tomato.png',
          fit: BoxFit.fitWidth,
          // fit: BoxFit.cover,
        ),
      ));
    }

    if (tasks.length > 0 && tasks.last.isDone == false) {
      tasks.last.isDone = true;
      Future.delayed(const Duration(milliseconds: 2500), () {
        showBreakBottomSheet(context);
      });
    }
    return completedcount;
  }

  void showBreakBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      // barrierColor: Colors.red,
      elevation: 25,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height / 3,
        decoration: const BoxDecoration(
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Take a break \n for 5 minutes \n',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ), //Textstyle
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shadowColor: Colors.black,
              ),
              child: const Text(
                'Get back to work',
              ),
            ), //
          ],
        ),
      ),
    );
  }
}
