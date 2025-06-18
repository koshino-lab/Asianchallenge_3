import 'package:flutter/material.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class AskQuestionPin extends StatelessWidget {
  final String imageAsset;
  final double width;
  final double height;
  final String riddle;
  final String pinId;
  final Function(String pinId, String answer) onSubmitAnswer;
  final bool isSolved;

  const AskQuestionPin({
    Key? key,
    required this.imageAsset,
    required this.width,
    required this.height,
    required this.riddle,
    required this.pinId,
    required this.onSubmitAnswer,
    required this.isSolved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSolved) {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('正解済み'),
                content: const Text('この問題はすでに正解しています。'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                    child: const Text('閉じる'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              final TextEditingController _answerController =
                  TextEditingController();
              return AlertDialog(
                title: const Text('謎々'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(riddle),
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        hintText: '解答を入力してください',
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      _answerController.dispose();
                    },
                    child: const Text('閉じる'),
                  ),
                  TextButton(
                    onPressed: () {
                      onSubmitAnswer(pinId, _answerController.text);
                      Navigator.of(dialogContext).pop();
                      _answerController.dispose();
                    },
                    child: const Text('解答する'),
                  ),
                ],
              );
            },
          );
        }
      },
      child: UniversalImage(imageAsset, width: width, height: height),
    );
  }
}
