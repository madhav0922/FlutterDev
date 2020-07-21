import 'dart:math';
import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/avatar_screen.dart';
import '../models/question_answer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/question_list.dart';
import '../widgets/answer_item.dart';

class StepCountScreen extends StatefulWidget {
  // final List<Question> questions = [
  //   Question(number: 10, step: 10),
  //   Question(number: 2, step: 2),
  //   Question(number: 3, step: 6),
  //   Question(number: 5, step: 5),
  // ];
  final List<int> answerOptions = [];
  @override
  _StepCountScreenState createState() => _StepCountScreenState();
}

class _StepCountScreenState extends State<StepCountScreen> {
  List<QuestionAnswerItem> qa = QuestionAnswer().generateQuestionAnswer();
  static int filledQuestions = 2 + Random().nextInt(2);
  int correctAnswerKey = Random().nextInt(4);
  int marks = filledQuestions * 10;

  void _marksHandler(bool answerType) {
    if (answerType)
      marks += 10;
    else
      marks += 5;
    print('marks=$marks');
  }

  void _changeQuestion() {
    setState(() {
      qa = QuestionAnswer().generateQuestionAnswer();
      filledQuestions = 2 + Random().nextInt(2);
      correctAnswerKey = Random().nextInt(4);
      marks = filledQuestions * 10;
    });
  }

  void _updateFilledQuestions() {
    print('lenenn ${qa[0].answers.length}');
    if (filledQuestions < qa[0].answers.length) {
      setState(() {
        filledQuestions++;
        correctAnswerKey = Random().nextInt(4);
      });
    }
    print('filled $filledQuestions');
  }

  void _generateAnswerOptions(int numberAsAnswer, int step) {
    print('crkey $correctAnswerKey');
    int i;
    for (i = 0; i < 4; i++) {
      if (i == correctAnswerKey)
        widget.answerOptions.insert(i, numberAsAnswer);
      else
        widget.answerOptions.insert(
          i,
          (numberAsAnswer - step * 2) + Random().nextInt(step * 5),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('marksinbuild=$marks');
    final questionsLength = qa[0].questions[0].noOfQuestions;
    final totalMarks = questionsLength * 10;
    if (filledQuestions < questionsLength) {
      final numberAsAnswer = qa[0].answers[filledQuestions].answer;
      final step = qa[0].questions[0].step;
      _generateAnswerOptions(numberAsAnswer, step);
    }
    if (filledQuestions == questionsLength)
      Timer(Duration(milliseconds: 500), _changeQuestion);

    final PreferredSizeWidget appBar = (Platform.isIOS)
        ? CupertinoNavigationBar(
            middle: Text('Step Count'),
            // trailing: IconButton(
            //   splashColor: Theme.of(context).primaryColor,
            //   icon: Icon(Icons.person),
            //   onPressed: () =>
            //       Navigator.of(context).pushNamed(AvatarScreen.routeName),
            // ),
          )
        : AppBar(
            title: Center(
              child: Text('Step Count'),
            ),
          );

    final mediaQueryHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: mediaQueryHeight,
        child: Column(
          children: <Widget>[
            //Progress Bar and Avatar
            Container(
              height: mediaQueryHeight * 0.15,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ProgressBar(marks, totalMarks),
                    ),
                    IconButton(
                      splashColor: Theme.of(context).primaryColor,
                      icon: Icon(Icons.person),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AvatarScreen.routeName),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: <Widget>[
                //Question List
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 40),
                  height: mediaQueryHeight * 0.3,
                  width: MediaQuery.of(context).size.width,
                  // will cause renderflex if not included width.
                  //alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  // child: SingleChildScrollView(
                  //   padding: const EdgeInsets.symmetric(horizontal: 2),
                  //   scrollDirection: Axis.horizontal,
                  child: Center(
                    child: QuestionList(filledQuestions, qa),
                  ),
                  //),
                ),
                Container(
                  height: mediaQueryHeight * 0.08,
                  margin: EdgeInsets.only(top: 10),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Choose an Answer: ',
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Answers
                if (filledQuestions < questionsLength)
                  Container(
                    height: mediaQueryHeight * 0.3,
                    // only margin separation between two widgets
                    margin: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: AnswerItem(
                      correctAnswerKey,
                      widget.answerOptions,
                      _updateFilledQuestions,
                      _marksHandler,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
