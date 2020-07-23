import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../screens/step_count_screen.dart';

class HomeScreen extends StatelessWidget {
  containerBuilder(
      BuildContext context, String text, Color color, String routename) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.5,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: RaisedButton(
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ),
          color: color,
          onPressed: () => Navigator.of(context).pushNamed(routename),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = (Platform.isIOS)
        ? CupertinoNavigationBar(
            middle: Text(''),
            // trailing: IconButton(
            //   splashColor: Theme.of(context).primaryColor,
            //   icon: Icon(Icons.person),
            //   onPressed: () =>
            //       Navigator.of(context).pushNamed(AvatarScreen.routeName),
            // ),
          )
        : AppBar(
            title: Center(
              child: Text(''),
            ),
          );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            height: mediaQuery.size.height * 0.35,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Center(
              child: FittedBox(
                child: Text(
                  'Step Count',
                  style: TextStyle(
                    fontSize: 120,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: mediaQuery.size.height * 0.45,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: <Widget>[
                containerBuilder(
                    context, 'Easy', Colors.yellow, StepCountScreen.routeName),
                containerBuilder(context, 'Medium', Colors.lightGreen,
                    StepCountScreen.routeName),
                containerBuilder(
                    context, 'Hard', Colors.red, StepCountScreen.routeName),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
