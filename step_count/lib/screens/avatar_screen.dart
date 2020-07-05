import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AvatarScreen extends StatelessWidget {
  static const routeName = '/avatar';
  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = (Platform.isIOS)
        ? CupertinoNavigationBar(
            middle: Text('Step Count'),
          )
        : AppBar(
            title: Text('Step Count'),
          );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Text(
          'Avatars coming soon!',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }
}
