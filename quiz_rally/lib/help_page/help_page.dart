import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ヘルプ')),
      body: Container(
        color: Styles.primaryColor,
        width: double.infinity,
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
