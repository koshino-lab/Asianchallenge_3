import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart'; // 必要であれば

class AnswerTextDialog {
  static Future<void> show({
    required BuildContext context,
    required String riddle,
    required String pinId,
    required void Function(String answer) onSubmit,
  }) {
    final TextEditingController _answerController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 336,
                height: 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.letterDialogSquare.path),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 26),

                    DarkBrownTexts.bold('Q U I Z  $pinId', 48),
                    const SizedBox(height: 26),

                    DarkBrownTexts(riddle, 20),
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _answerController,
                        decoration: const InputDecoration(
                          hintText: '解答を入力してください',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            onSubmit(_answerController.text);
                            Navigator.of(context).pop();
                            _answerController.dispose();
                          },
                          child: UniversalImage(
                            Assets.images.redDecoratedButtonSubmit.path,
                            height: 60,
                          ),
                        ),
                        const SizedBox(width: 30),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                height: 50,
                width: 50,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Center(
                    child: UniversalImage(Assets.images.closeRedButton.path),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
