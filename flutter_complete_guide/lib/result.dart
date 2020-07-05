import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    // getter function. cannot recieve arguments hence no parenthesis. Getter should always return something though.
    String resultText;
    if (resultScore < 8)
      resultText = 'You are amazing!';
    else if (resultScore <= 12)
      resultText = 'You are good!';
    else if (resultScore <= 16)
      resultText = 'You are strange?!';
    else
      resultText = 'You are so bad!';
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            child: Text('Restart Quiz!'),
            textColor: Colors.blue,
            onPressed: resetHandler,
          ),
        ],
      ),
    );
  }
}
