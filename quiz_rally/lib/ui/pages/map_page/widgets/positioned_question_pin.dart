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
    // 画像アセット名をpinIdから取得
    final imageAsset = _getImageAsset(pinId);

    return Positioned(
      top: top,
      right: right,
      left: left,
      bottom: bottom,
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
      case 5:
        return Assets.images.pin5;
      case 6:
        return Assets.images.pin6.path;
      case 7:
        return Assets.images.pin7.path;
      case 8:
        return Assets.images.pin8.path;
      case 9:
        return Assets.images.pin9.path;
      default:
        return Assets.images.pin1;
    }
  }
}
