import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/correct_contents.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/wrong_contents.dart';

final dialogIndexProvider = StateProvider.autoDispose<int>(
  (ref) => 0,
); //0:回答画面 1:正解画面 2:不正解画面

class AnswerTextDialog extends ConsumerWidget {
  final String riddle;
  final int pinId;
  final String hint;
  final Future<bool> Function(String answer) onSubmit;
  final double correctAnsRate;
  //final Future<bool> Function(String answer) isCorrectAns;

  const AnswerTextDialog({
    super.key,
    required this.riddle,
    required this.pinId,
    required this.onSubmit,
    required this.correctAnsRate,
    this.hint = '',
  });

  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required String riddle,
    required int pinId,
    required Future<bool> Function(String answer) onSubmit,
    required double correctAnsRate,
    required String hint,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProviderScope(
        child: AnswerTextDialog(
          riddle: riddle,
          pinId: pinId,
          onSubmit: onSubmit,
          correctAnsRate: correctAnsRate,
          hint: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogIndex = ref.watch(dialogIndexProvider);
    final TextEditingController _answerController = TextEditingController();

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
                DarkBrownTexts('正答率: $correctAnsRate', 20),
                if (dialogIndex == 0)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 26),
                      DarkBrownTexts.bold('Q U I Z  $pinId', 48),
                      const SizedBox(height: 26),
                      DarkBrownTexts(riddle, 20),
                      const SizedBox(height: 26),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              final ans = _answerController.text;
                              final isCorrectAns = await onSubmit(ans);
                              _answerController.dispose();
                              if (isCorrectAns) {
                                ref.read(dialogIndexProvider.notifier).state =
                                    1; // 正解画面へ
                              } else {
                                ref.read(dialogIndexProvider.notifier).state =
                                    2; // 不正解画面へ
                              }
                            },
                            child: UniversalImage(
                              Assets.images.redDecoratedButtonSubmit.path,
                              height: 60,
                            ),
                          ),
                          const SizedBox(width: 35),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if (dialogIndex == 1) CorrectContents(pinId: pinId),
                if (dialogIndex == 2)
                  WrongContents(
                    pinId: pinId,
                    hint: hint,
                    back: () {
                      ref.read(dialogIndexProvider.notifier).state = 0;
                    },
                  ),
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
  }
}
