import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String answerText;
  Answer({Key? key, required this.selectHandler, required this.answerText})
      : super(key: key);

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: ElevatedButton(
        style: style,
        onPressed: () => selectHandler(),
        child: Text(answerText),
      ),
    );
  }
}
