import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class AnswerItem extends StatefulWidget {
  final int numberAsAnswer;
  final int questionStep;
  final Function filledQuestionsHandler;
  Color buttonColor = Colors.blue;
  final correctAnswerKey = Random().nextInt(4);

  AnswerItem(
      this.numberAsAnswer, this.questionStep, this.filledQuestionsHandler);

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  void _checkAnswer(int i, int correctAnswerKey, Color buttonColor) {
    if (i == correctAnswerKey) {
      widget.filledQuestionsHandler();
      setState(() {
        buttonColor = Colors.green;
        // sleep(Duration(seconds: 1));
      });
    } else
      print('Wrong answer!');
    // setState(() {
    //   buttonColor = Colors.red;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 1,
        crossAxisSpacing: 40,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (ctx, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FlatButton(
            color: (index == widget.correctAnswerKey)
                ? widget.buttonColor
                : Theme.of(context).primaryColor,
            splashColor: (index != widget.correctAnswerKey)
                ? widget.buttonColor
                : Theme.of(context).primaryColor,
            key: ValueKey(index),
            onPressed: () => _checkAnswer(
                index, widget.correctAnswerKey, widget.buttonColor),
            child: Text(
              (index == widget.correctAnswerKey)
                  ? '${widget.numberAsAnswer}'
                  : (widget.numberAsAnswer -
                          (widget.questionStep * 3) +
                          Random().nextInt(widget.questionStep * 3))
                      .toString(),
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
