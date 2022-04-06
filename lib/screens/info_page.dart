import 'package:flutter/material.dart';

import 'widgets/dev_widgets.dart';

class PomodoroInfo extends StatelessWidget {
  const PomodoroInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TodoWidget(
      todoClassName: '$runtimeType',
    );
  }
}
