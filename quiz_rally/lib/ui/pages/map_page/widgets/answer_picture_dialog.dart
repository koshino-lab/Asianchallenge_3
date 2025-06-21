import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/answer_text_dialog.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/correct_contents.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/wrong_contents.dart';

class AnswerPictureDialog extends ConsumerWidget {
  final String riddle;
  final int pinId;
  final String hint;
  final Future<bool> Function(String answer) onSubmit;
  //final Future<bool> Function(String answer) isCorrectAns;
  final VoidCallback? onCameraPressed;
  final XFile? imageFile;

  const AnswerPictureDialog({
    super.key,
    required this.riddle,
    required this.pinId,
    required this.onSubmit,
    //required this.isCorrectAns,
    required this.hint,
    this.onCameraPressed,
    this.imageFile,
  });

  static Future<void> show({
    required BuildContext context,
    required WidgetRef ref,
    required String riddle,
    required int pinId,
    required Future<bool> Function(String answer) onSubmit,
    required Future<bool> Function(String answer) isCorrectAns,
    required String hint,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ProviderScope(
        child: AnswerPictureDialog(
          riddle: riddle,
          pinId: pinId,
          onSubmit: onSubmit,
          // isCorrectAns: isCorrectAns,
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
                if (dialogIndex == 0)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 26),
                      DarkBrownTexts.bold('Q U I Z  $pinId', 48),
                      const SizedBox(height: 26),
                      DarkBrownTexts(riddle, 20),
                      const SizedBox(height: 26),
                      if (pinId != 1)
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
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: onCameraPressed,
                      ),
                      if (imageFile != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: kIsWeb
                              ? FutureBuilder<Uint8List>(
                                  future: imageFile!.readAsBytes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.done &&
                                        snapshot.hasData) {
                                      return ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 50,
                                          maxHeight: 50,
                                        ),
                                        child: Image.memory(
                                          snapshot.data!,
                                          fit: BoxFit.cover, // ← 塗りつぶしながら比率維持
                                        ),
                                      );
                                    } else {
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                )
                              : Image.file(
                                  File(imageFile!.path),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (imageFile != null) {
                                List<int> imageBytes = await imageFile!.readAsBytes();
                                final answer = base64Encode(imageBytes);
                                final isCorrectAns = await onSubmit(answer);
                                if (isCorrectAns) {
                                  ref.read(dialogIndexProvider.notifier).state =
                                      1; // 正解画面へ
                                } else {
                                  ref.read(dialogIndexProvider.notifier).state =
                                      2; // 不正解画面へ
                                }
                              }
                              // 写真がなければ何もしない
                              return;
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
