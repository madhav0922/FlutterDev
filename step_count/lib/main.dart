import 'package:flutter/material.dart';
<<<<<<< HEAD

import './models/question.dart';
import 'progress_bar.dart';
import 'question_list.dart';
import 'answers.dart';

void main() => runApp(MyApp());
=======
import 'package:flutter/services.dart';

import './screens/step_count_screen.dart';
import './screens/avatar_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

>>>>>>> commit

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StepCount(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                color: Colors.blue,
                fontSize: 50,
              ),
            ),
      ),
    );
  }
}

class StepCount extends StatefulWidget {
  @override
  _StepCountState createState() => _StepCountState();
}

class _StepCountState extends State<StepCount> {
  @override
  final List<Question> questions = [
    Question(number: 10, step: 10),
    Question(number: 2, step: 2),
    Question(number: 3, step: 6),
    Question(number: 5, step: 5),
  ];

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Step Count'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Progress Bar and Avatar
          Container(
            height: mediaQuery.size.height * 0.1,
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: mediaQuery.size.width * 0.7,
                    child: ProgressBar(),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    width: mediaQuery.size.width * 0.1,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Question List
          Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: mediaQuery.size.height * 0.2,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: QuestionList(),
              ),
            ),
          ),
          // Answers
          Container(
            height: mediaQuery.size.height * 0.4,
            // only margin separation between two widgets
            margin: EdgeInsets.all(10),
            child: Answers(),
          ),
        ],
      ),
                color: Colors.white,
                fontSize: 30,
              ),
              headline5: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
      ),
      home: StepCountScreen(),
      routes: {
        AvatarScreen.routeName: (ctx) => AvatarScreen(),
      },
    );
  }
}