import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('マップ')),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/problem');
              },
              child: const Text('問題へすすむ'))
        ],
      ),
    );
  }
}
