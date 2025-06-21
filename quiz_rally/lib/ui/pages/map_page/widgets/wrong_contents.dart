import 'package:flutter/material.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class WrongContents extends StatelessWidget {
  final int pinId;
  final String hint;
  final void Function() back;

  const WrongContents({
    super.key,
    required this.pinId,
    required this.hint,
    required this.back,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10),
        DarkBrownTexts.bold('Q U I Z  $pinId', 48),
        const SizedBox(height: 4),
        DarkBrownTexts.bold('不正解！', 36),
        const SizedBox(height: 180),
        DarkBrownTexts('ヒント：${hint.isEmpty ? 'なし' : hint}', 20),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 40),
            InkWell(
              onTap: back,
              child: UniversalImage(
                Assets.images.rectangleBack.path,
                height: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
