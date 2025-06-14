import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';

class ProblemPage extends StatelessWidget {
  const ProblemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('鎖の問題')),
      body: Container(
        color: Styles.primaryColor700,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/success');
                },
                child: const Text('成功画面にすすむ'))
          ],
        ),
      ),
    );
  }
}
