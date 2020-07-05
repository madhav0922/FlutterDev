import 'package:flutter/foundation.dart';

import 'question.dart';
import 'answer.dart';

class QuestionAnswerItem {
  List<QuestionItem> questions;
  List<AnswerItem> answers;

  QuestionAnswerItem({
    @required this.questions,
    @required this.answers,
  });
}

class QuestionAnswer {
  List<QuestionAnswerItem> _questionAnswerList = [];

  List<QuestionAnswerItem> generateQuestionAnswer() {
    final List<QuestionItem> questions = Question().generateQuestion();
    _questionAnswerList.add(
      QuestionAnswerItem(
        questions: questions,
        answers: Answer().generateAnswers(questions),
      ),
    );
    print(_questionAnswerList[0].answers.toString());
    return _questionAnswerList;
  }
}
