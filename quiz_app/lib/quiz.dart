import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 80, right: 10, bottom: 10),
        child: Column(
          children: [
            Question(
                questionText:
                    questions[questionIndex]['questionText'].toString()),
            ...(questions[questionIndex]['answers'] as List<Map>).map(
                (answer) => Answer(
                    selectHandler: () => answerQuestion(answer['score']),
                    answerText: answer['text'])),
          ],
        ),
      ),
    );
  }
}
