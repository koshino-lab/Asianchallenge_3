import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/services/quiz_service.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/answer_text_dialog.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/answer_picture_dialog.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/solveDialog.dart';
import 'package:image_picker/image_picker.dart';

class PositionedQuestionPin extends ConsumerWidget {
  final double? top;
  final double? right;
  final double? left;
  final double? bottom;
  final int pinId;
  final double pinSize = 80.0;
  final double checkIconSize = 40.0;

  const PositionedQuestionPin({
    super.key,
    this.top,
    this.right,
    this.left,
    this.bottom,
    required this.pinId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);
    final isSolved = mapPageState.solvedPinIds.contains(pinId);
    // 画像アセット名をpinIdから取得
    final imageAsset = _getImageAsset(pinId);

    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
      child: GestureDetector(
        onTap: () async {
          if (isSolved) {
            await SolvedDialog.show(context, pinId);
          } else {
            try {
              final quiz = await mapPageController.getQuiz(pinId);
              final riddle = quiz.quiz;
              final type = quiz.type;
              final hint = quiz.hint;
              print('✅ Quiz fetched: $riddle, type: $type, hint: $hint');
              if (type == 1) {
                XFile? imageFile;
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AnswerPictureDialog(
                          riddle: riddle,
                          hint: hint,
                          onSubmit: (answer) =>
                              mapPageController.checkAnswer(pinId, answer),
                          onCameraPressed: () async {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (pickedFile != null) {
                              setState(() {
                                imageFile = pickedFile;
                              });
                              ScaffoldMessenger.of(dialogContext).showSnackBar(
                                const SnackBar(content: Text('写真を撮影しました')),
                              );
                            }
                          },
                          imageFile: imageFile,
                          pinId: pinId,
                        );
                      },
                    );
                  },
                );
              } else {
                AnswerTextDialog.show(
                  context: context,
                  ref: ref,
                  riddle: riddle,
                  pinId: pinId,
                  hint: hint,
                  onSubmit: (answer) =>
                      mapPageController.checkAnswer(pinId, answer),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('クイズの取得に失敗しました: $e')));
              print('❌ Error fetching quiz: $e');
            }
          }
        },
        child: Column(
          children: [
            SizedBox(
              width: checkIconSize,
              height: checkIconSize,
              child: mapPageState.solvedPinIds.contains(pinId)
                  ? UniversalImage(Assets.images.check)
                  : const SizedBox.shrink(),
            ),
            UniversalImage(imageAsset, width: pinSize, height: pinSize),
          ],
        ),
      ),
    );
  }

  String _getImageAsset(int pinId) {
    switch (pinId) {
      case 1:
        return Assets.images.pin1;
      case 2:
        return Assets.images.pin2;
      case 3:
        return Assets.images.pin3;
      case 4:
        return Assets.images.pin4;
      default:
        return Assets.images.pin1;
    }
  }
}
