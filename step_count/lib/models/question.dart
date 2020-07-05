import 'dart:math';

import 'package:flutter/foundation.dart';

class QuestionItem {
  final int number;
  final int step;
  final int noOfQuestions;

  QuestionItem({
    @required this.number,
    @required this.step,
    @required this.noOfQuestions,
  });
}

class Question {
  List<QuestionItem> _questionList = [];

  List<QuestionItem> generateQuestion() {
    final minN = 4, maxN = 10, minS = 2, maxS = 5;

    final number = minN + Random().nextInt(maxN - minN);
    final step = minS + Random().nextInt(maxS - minS);
    final noOfQuestions = 4 + Random().nextInt(3);

    _questionList.add(
      QuestionItem(
        number: number,
        step: step,
        noOfQuestions: noOfQuestions,
      ),
    );

    return _questionList;
  }
}
