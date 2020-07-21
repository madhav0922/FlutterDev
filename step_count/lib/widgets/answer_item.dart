import 'dart:async';

import 'package:flutter/material.dart';

class AnswerItem extends StatefulWidget {
  //Color buttonColor = Colors.blue;
  final correctAnswerKey;
  final List<int> answersShown;
  final Function filledQuestionsHandler;
  final Function marksHandler;
  final List<Color> buttonColor = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
  ];

  AnswerItem(
    this.correctAnswerKey,
    this.answersShown,
    this.filledQuestionsHandler,
    this.marksHandler,
  );

  @override
  _AnswerItemState createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  void _updateAnswer() {
    widget.filledQuestionsHandler();
  }

  void _checkAnswer(int i) {
    if (i == widget.correctAnswerKey) {
      setState(() {
        widget.buttonColor[i] = Colors.green;
        widget.marksHandler(true);
      });
    } else
      setState(() {
        widget.buttonColor[i] = Colors.red;
        widget.marksHandler(false);
      });
    Timer(Duration(milliseconds: 500), _updateAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 9 / 1,
        crossAxisSpacing: 40,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (ctx, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: FlatButton(
            color: widget.buttonColor[index],
            //splashColor: widget.buttonColor[index],
            onPressed: () => _checkAnswer(index),
            child: Text(
              widget.answersShown[index].toString(),
              // (index == widget.correctAnswerKey)
              //     ? '${widget.numberAsAnswer}'
              //     : (widget.numberAsAnswer -
              //             (widget.questionStep * 3) +
              //             Random().nextInt(widget.questionStep * 3))
              //         .toString(),
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
