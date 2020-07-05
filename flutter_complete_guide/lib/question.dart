import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // if this had _ before name then it can't be used in other files, but we are now using it in main.dart to send values here.
  final String questionText;
  // adding final tells flutter that this variable will never change at runtine after its initialization here in the constructor, so that it doesnt change from inside the class as well.

  Question(this.questionText);
  // constructor with positional argument. not named. named argument has curly braces inside to limit, and not as well, the parameters. Question({this.questionText})

  @override
  Widget build(BuildContext context) {
    return Container(
      // container with child and without container, wont center the text in the app, because it takes the size of the text and not the device. whose center we want to achieve.
      width: double.infinity,
      // setting the width makes us achieve that, by taking the width of the screen of the device.
      margin: EdgeInsets.all(10),
      // all does all directions, only targets onely one direction..etc
      child: Text(
        questionText,
        style: TextStyle(
            fontSize: 30), // this is instantiation of a class called TextStyle
        textAlign: TextAlign.center,
        // .center is an enum of TextAlign, it assigns labels
      ),
    );
  }
}
