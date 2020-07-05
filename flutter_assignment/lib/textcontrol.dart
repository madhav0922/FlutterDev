import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final List text;
  final int textIndex;
  final Function textHandler;

  TextControl({this.text, this.textIndex, this.textHandler});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(text[textIndex]),
          RaisedButton(
            child: Text('button'),
            onPressed: textHandler,
          ),
        ],
      ),
    );
  }
}
