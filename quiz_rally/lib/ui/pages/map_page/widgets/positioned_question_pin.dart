import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  final String pinId;
  final double pinSize = 80.0;

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
    final riddle = MapPageController.mapPins[pinId]?.riddle ?? '';
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
            if (pinId == 'pin1') {
              XFile? imageFile;
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AnswerPictureDialog(
                        riddle: riddle,
                        onSubmit: (answer) {
                          mapPageController.submitPinAnswer(pinId, answer);
                        },
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
                onSubmit: (answer) {
                  mapPageController.submitPinAnswer(pinId, answer);
                },
                isCorrectAns: (answer) {
                  return mapPageController.isCorrectAnswer(pinId, answer);
                },
              );
            }
          }
        },
        child: UniversalImage(imageAsset, width: pinSize, height: pinSize),
      ),
    );
  }

  String _getImageAsset(String pinId) {
    switch (pinId) {
      case 'pin1':
        return Assets.images.pin1;
      case 'pin2':
        return Assets.images.pin2;
      case 'pin3':
        return Assets.images.pin3;
      case 'pin4':
        return Assets.images.pin4;
      default:
        return Assets.images.pin1;
    }
  }
}
