import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

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
                        mapPageController.submitPinAnswer(
                          pinId,
                          _answerController.text,
                        );
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
