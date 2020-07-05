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

  List<QuestionAnswerItem> qa = QuestionAnswer().generateQuestionAnswer();
  int filledQuestions = 2 + Random().nextInt(2);
  final List<int> answerOptions = [];
  final correctAnswerKey = Random().nextInt(4);
  @override
  _StepCountScreenState createState() => _StepCountScreenState();
}

class _StepCountScreenState extends State<StepCountScreen> {
  void _changeQuestion() {
    setState(() {
      widget.qa = QuestionAnswer().generateQuestionAnswer();
      widget.filledQuestions = 2 + Random().nextInt(2);
    });
  }

  void _updateFilledQuestions() {
    setState(() {
      if (widget.filledQuestions < widget.qa[0].answers.length)
        ++widget.filledQuestions;
      print('filled ${widget.filledQuestions}');
    });
  }

  void _generateAnswerOptions(int numberAsAnswer, int step) {
    print('crkey ${widget.correctAnswerKey}');
    int i;
    for (i = 0; i < 4; i++) {
      if (i == widget.correctAnswerKey)
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
    final numberAsAnswer = widget.qa[0].answers[widget.filledQuestions].answer;
    final step = widget.qa[0].questions[0].step;
    _generateAnswerOptions(numberAsAnswer, step);

    if (widget.filledQuestions == widget.qa[0].questions[0].noOfQuestions)
      Timer(Duration(seconds: 1), _changeQuestion);
    final mediaQuery = MediaQuery.of(context);
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
            title: Text('Step Count'),
          );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top,
        child: Column(
          children: <Widget>[
            //Progress Bar and Avatar
            Container(
              height: mediaQuery.size.height * 0.12,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ProgressBar(),
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
            //Question List
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: mediaQuery.size.height * 0.3,
              child: Card(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  scrollDirection: Axis.horizontal,
                  child: QuestionList(widget.filledQuestions, widget.qa),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Choose an Answer: ',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),
            // Answers
            if (widget.filledQuestions < widget.qa[0].answers.length)
              Container(
                height: mediaQuery.size.height * 0.25,
                // only margin separation between two widgets
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: AnswerItem(widget.correctAnswerKey, widget.answerOptions,
                    _updateFilledQuestions),
              ),

            // if (widget.filledQuestions ==
            //     widget.qa[0].questions[0].noOfQuestions)
          ],
        ),
      ),
    );
  }
}
