import 'package:flutter/material.dart';

import '../models/question_answer.dart';

class QuestionList extends StatelessWidget {
  final int _filledQuestions;
  final List<QuestionAnswerItem> _qaList;

  QuestionList(this._filledQuestions, this._qaList);

  @override
  Widget build(BuildContext context) {
    print('filledq $_filledQuestions');
    // print(number);
    // print(step);
    // print(noOfQuestions);
    // print(filledQuestions);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          print('i $index');
          return Row(
            children: <Widget>[
              if (index < _filledQuestions)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.lightGreenAccent,
                    child: CircleAvatar(
                      radius: 44,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          '${_qaList[0].answers[index].answer}',
                          style: TextStyle(color: Colors.white, fontSize: 60),
                        ),
                      ),
                    ),
                  ),
                ),
              if (index >= _filledQuestions)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: CircleAvatar(
                    child: null,
                    radius: 60,
                    backgroundColor: Theme.of(context).primaryColor,
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
        itemCount: _qaList[0].answers.length,
      ),
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