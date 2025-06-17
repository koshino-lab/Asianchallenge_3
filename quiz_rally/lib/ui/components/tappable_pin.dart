import 'package:flutter/material.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class TappablePin extends StatelessWidget {
  final String imageAsset;
  final double width;
  final double height;
  final String riddle;
  final String pinId;
  final Function(String pinId, String answer) onSubmitAnswer;

  const TappablePin({
    Key? key,
    required this.imageAsset,
    required this.width,
    required this.height,
    required this.riddle,
    required this.pinId,
    required this.onSubmitAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                    decoration: const InputDecoration(hintText: '解答を入力してください'),
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
      },
      child: UniversalImage(imageAsset, width: width, height: height),
    );
  }
}
