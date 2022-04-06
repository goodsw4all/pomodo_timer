import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {
  final String todoClassName;
  const TodoWidget({Key? key, required this.todoClassName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
            color: const Color(0xFFF05A22),
            style: BorderStyle.solid,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'TODO : $todoClassName',
          style: const TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
