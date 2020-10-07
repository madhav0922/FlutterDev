import 'package:flutter/material.dart';

import '../models/question_answer.dart';

class QuestionList extends StatelessWidget {
  final int _filledQuestions;
  final List<QuestionAnswerItem> _qaList;

  QuestionList(this._filledQuestions, this._qaList);

  @override
  Widget build(BuildContext context) {
    // print(number);
    // print(step);
    // print(noOfQuestions);
    // print(filledQuestions);
    print('len ${_qaList[0].answers.length}');
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        print('filledq $_filledQuestions');
        print('i $index');
        return Row(
          children: <Widget>[
            if (index < _filledQuestions)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          // width: 100,
                          // height: 100,
                          child: AnimatedOpacity(
                            opacity: 0.5,
                            duration: Duration(seconds: 1),
                            child: Image.asset(
                              'assets/images/gear.png',
                              color: Colors.green,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              '${_qaList[0].answers[index].answer}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ),
                    // ),
                  ),
                ),
              ),
            if (index >= _filledQuestions)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                // width: 100,
                // height: 100,
                child: AnimatedOpacity(
                  opacity: 0.5,
                  duration: Duration(seconds: 1),
                  child: Image.asset(
                    'assets/images/gear.png',
                    color: Colors.blue,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // if (index == filledQuestions)
            //   StepCountScreen(qa[0].answers[index].answer),
            SizedBox(
              width: 10,
            ),
          ],
        );
      },
      itemCount: _qaList[0].questions[0].noOfQuestions,
      // ),
      //   ),
      // //Answers
      // Expanded(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height * 0.7,
      //     width: MediaQuery.of(context).size.width,
      //     // only margin separation between two widgets
      //     padding: EdgeInsets.all(10),
      //     child: AnswerItem(qa[0].answers[filledQuestions].answer),
      //   ),
      // ),
    );
  }
}
