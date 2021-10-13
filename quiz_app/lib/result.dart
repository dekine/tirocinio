import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(
      {Key? key, required this.resultScore, required this.resetHandler})
      : super(key: key);

  String get resultPhrase {
    String resultText;
    if (resultScore <= 8) {
      resultText = 'You are awesome and innocent!';
    } else if (resultScore <= 12) {
      resultText = 'Pretty likeable!';
    } else if (resultScore <= 16) {
      resultText = 'You are ... strange?!';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 150, right: 10, bottom: 10),
        child: Column(
          children: [
            Text(
              'Score: $resultScore',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              resultPhrase,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: resetHandler,
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
