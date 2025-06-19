import 'package:flutter/material.dart';

class AnswerTextDialog extends StatelessWidget {
  final String riddle;
  final void Function(String answer) onSubmit;
  const AnswerTextDialog({
    super.key,
    required this.riddle,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController _answerController = TextEditingController();
    return AlertDialog(
      title: const Text('謎々'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(riddle),
          TextField(
            controller: _answerController,
            decoration: const InputDecoration(hintText: '解答を入力してください'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _answerController.dispose();
          },
          child: const Text('閉じる'),
        ),
        TextButton(
          onPressed: () {
            onSubmit(_answerController.text);
            Navigator.of(context).pop();
            _answerController.dispose();
          },
          child: const Text('解答する'),
        ),
      ],
    );
  }
}
