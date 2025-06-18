import 'package:flutter/material.dart';

class SolvedDialog extends StatelessWidget {
  const SolvedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('正解済み'),
      content: const Text('この問題はすでに正解しています。'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
