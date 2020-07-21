import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final marks;
  final totalMarks;

  ProgressBar(this.marks, this.totalMarks);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              color: Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          FractionallySizedBox(
            widthFactor: (marks / totalMarks),
            child: Container(
              height: 20,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
