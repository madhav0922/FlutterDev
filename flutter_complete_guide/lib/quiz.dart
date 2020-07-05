import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    @required this.questions,
    @required this.answerQuestion,
    @required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Question(questions[questionIndex]['questionText']),
        // imported from question.dart to send the question there.
        // also the state less widget (Question) in question.dart changed because we changed data externally
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            //...(spread operator) adds the values of a list to the new list created by flutter and add it to the surrounding list rather than the whole list just copied
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), answer['text']);
          // anonymous function to get different scores only when button is pressed and according to the button
        }).toList() // converting map values to list (like toString method)
      ],
    ));
  }
}
