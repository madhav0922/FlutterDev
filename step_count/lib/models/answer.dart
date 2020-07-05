import 'package:flutter/foundation.dart';

import './question.dart';

class AnswerItem {
  final int answer;

  AnswerItem({
    @required this.answer,
  });
}

class Answer {
  final List<AnswerItem> _answers = [];
  int addAnswer;
  List<AnswerItem> generateAnswers(List<QuestionItem> question) {
    for (var i = 0; i < question[0].noOfQuestions; i++) {
      if (i == 0)
        addAnswer = question[0].number;
      else
        addAnswer += question[0].step;
      _answers.add(
        AnswerItem(
          answer: addAnswer,
        ),
      );
    }
    print('No of q ${question[0].noOfQuestions}');
    for (var i = 0; i < question[0].noOfQuestions; i++)
      print('a : ${_answers[i].answer}');
    return _answers;
  }
}
