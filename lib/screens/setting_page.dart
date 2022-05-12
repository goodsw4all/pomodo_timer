import 'dart:io';

import 'package:flutter/material.dart';

import '../model/pomodoro_setting.dart';
import 'widgets/dev_widgets.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key) {}

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<int> workTimeItems = [25, 20, 15, 10];
  List<int> breakTimeItems = [5, 10, 15];
  var selectedItemWork;
  var selectedItemBreak;

  @override
  void initState() {
    selectedItemWork = workTimeItems[0];
    selectedItemBreak = breakTimeItems[0];
  }

  @override
  Widget build(BuildContext context) {
    selectedItemWork = PomodoroSetting.getScheduleValue("WORK");
    selectedItemBreak = PomodoroSetting.getScheduleValue('BREAK');

    print("_SettingPageState $selectedItemWork $selectedItemBreak");
    return Column(
      children: [
        Spacer(flex: 3),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildSetting("WORK", selectedItemWork, workTimeItems),
              buildSetting("BREAK", selectedItemBreak, breakTimeItems),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            primary: Colors.teal,
            // onPrimary: Colors.white,
            side: BorderSide(color: Colors.white54, width: 1),
          ),
          onPressed: () {},
          child: Text("Save"),
        ),
        Spacer(flex: 3),
      ],
    );
  }

  Widget buildSetting(String type, selectedItem, List<int> items) {
    String textValue = type;
    return Row(
      children: [
        Text(
          textValue,
          style: TextStyle(color: Colors.green, fontSize: 13),
        ),
        SizedBox(
          width: 10,
        ),
        Center(
          child: buildDropDownButton(type, selectedItem, items),
        ),
      ],
    );
  }

  Container buildDropDownButton(String type, selectedItem, List<int> items) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<int>(
        elevation: 3,
        underline: SizedBox(),
        style: TextStyle(color: Colors.green, fontSize: 15),
        value: selectedItem,
        items: items
            .map(
              (item) => DropdownMenuItem<int>(
                value: item,
                child: Text(
                  "$item mins",
                ),
              ),
            )
            .toList(),
        onChanged: (item) {
          setState(() {
            selectedItemWork = item;

            print("$item, $selectedItem");
          });
        },
      ),
    );
  }
}
