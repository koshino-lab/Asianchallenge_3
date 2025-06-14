import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('成功')),
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
