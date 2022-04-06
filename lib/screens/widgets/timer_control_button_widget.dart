import 'package:flutter/material.dart';

class TimerControlButton extends StatelessWidget {
  final VoidCallback onPressHandler;
  final Icon icon;

  TimerControlButton({
    required this.icon,
    required this.onPressHandler,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 15,
      constraints:
          const BoxConstraints(), // removes empty spaces around of icon
      shape: const CircleBorder(), // circular button
      fillColor: const Color(0xffff6464), // background color
      splashColor: Colors.red,
      highlightColor: Colors.red,
      child: icon,
      padding: const EdgeInsets.all(8),
      onPressed: onPressHandler,
    );
  }
}
