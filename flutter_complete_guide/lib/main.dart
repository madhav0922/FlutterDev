import 'package:flutter/material.dart'; //contains built in widgets with material themeing

import 'quiz.dart';
import 'result.dart';
// void main() {
//   runApp(MyApp());    // to run our CORE widget tree
// }

// alternative syntax for main() for only one expression or line

void main() => runApp(MyApp());
// if this MyApp() or runApp return something that would also automatically be returned by main

// class MyApp extends StatelessWidget {    // only this will arise a .build error, that class is not implemented properly
//   @override                               // is a decorator that overrides the build method with our own, rather than what class specifies, makes our project cleaner
//   Widget build(BuildContext context) {    // therfore a build context is added because, there might be a method of class like "build" here
//     // TODO: implement build              //this needs to return a Widget as the return type signifies.
//                                           // Therefore, providing MaterialApp() widget included in material.dart
//     return MaterialApp(home: Text('Hello!'),); //These arent functions but classes
//   }
// }

// NOW WORKING WITH SCAFFOLD\  A helper widget

class MyApp extends StatefulWidget {
  // This will generate or create new state
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState(); // since createState() returns State
  }
}

class _MyAppState extends State<MyApp> {
  // This class will stay persistent (like static)
  //_ before class name, variable, methods, fns etc ensure they can't be accessed from outside the main.dart or a dart file. basically makes them private from public.
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
      // anonymous function as an argument to function, to put the line or code you want to change
    });
    print(_questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // var questions = [
    //   'What\'s your favourite colour?',
    //   'What\'s your favourite sport?'
    // ];

    // Converted to MAP data structure

    // list starts
    // why const and not final, because const is a compile time constant,
    // we do not want to change the values contained in this list even at runtime. (final does not allow change of values at runtime, but at compile time they can change or initialize)
    // Compile time constant also implicitly means runtime constant.
    final _questions = const [
      //map starts
      {
        'questionText': 'What\'s your favourite colour?',
        'answers': [
          {'text': 'Black', 'score': 10},
          {'text': 'Green', 'score': 5},
          {'text': 'Yellow', 'score': 3},
          {'text': 'White', 'score': 1},
        ],
      },
      {
        'questionText': 'What\'s your favourite sport?',
        'answers': [
          {'text': 'Tennis', 'score': 10},
          {'text': 'Cricket', 'score': 5},
          {'text': 'Hockey', 'score': 3},
          {'text': 'Baseball', 'score': 1},
        ],
      },
      {
        'questionText': 'What\'s your favourite animal?',
        'answers': [
          {'text': 'Elephant', 'score': 1},
          {'text': 'Tiger', 'score': 1},
          {'text': 'Hooman LOL', 'score': 1},
        ],
      },
    ];
    // return MaterialApp(
    //   home: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Intro'),
    //     ),
    //     body: Column(
    //       children: [
    //         Question(questions[
    //             _questionIndex]), // imported from question.dart to send the question there.
    //         // also the state less widget (Question) in question.dart changed because we changed data externally
    //         RaisedButton(
    //           child: Text('Answer1'),
    //           onPressed: _answerQuestion, // concept of named function
    //         ),
    //         RaisedButton(
    //           child: Text('Answer 2'),
    //           onPressed: () => print(
    //               'Answer 2 chosen!'), // () concept of anonymous function single line
    //         ),
    //         RaisedButton(
    //           child: Text('Answer 3'),
    //           onPressed: () {
    //             // () anonymous function with larger body
    //             // ... do some stuff
    //             print('Answer 3 chosen!');
    //           },
    //         ),
    //       ],
    //     ),
    //   ), // we can specify widgets and their styling here in scaffold
    // );

    ////////// CONCEPT OF LIFTING THE STATE UP ////////////

    // definition:  you manage the state on the shared, on the common denominator of the different
    //              widgets that need this state and that is the direct parent of these widgets that need the state.

    // WE HAVE A COMMON PARENT OF TWO THINGS THAT WANT TO CHANGE STATE,
    //I.E Question and Answer. as diff questions have diff answers, therefore
    //we are making a state that is stateful which will allow both
    //stateless Question in question.dart and stateless answer in answer.dart to change states

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Intro'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                questions: _questions,
                questionIndex: _questionIndex,
              )
            : Result(_totalScore, _resetQuiz),
      ), // we can specify widgets and their styling here in scaffold
    );
  }
}
