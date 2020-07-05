import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  //final numberAsAnswer;

  //Answers(this.numberAsAnswer);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Card(
          elevation: 5,
          child: Text(
            'Answer 1',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          elevation: 5,
          child: Text(
            'Answer 2',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          elevation: 5,
          child: Text(
            'Answer 3',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        Card(
          elevation: 5,
          child: Text(
            'Answer 4',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
