import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ヘルプ')),
      body: Container(
        color: Styles.primaryColor700,
        width: double.infinity,
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}

final helpList = [1, 2, 3, 4, 5];
