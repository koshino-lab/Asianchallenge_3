import 'package:flutter/widgets.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class CorrectContents extends StatelessWidget {
  final String pinId;

  const CorrectContents({super.key, required this.pinId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10),
        DarkBrownTexts.bold('Q U I Z  $pinId', 48),
        const SizedBox(height: 4),
        DarkBrownTexts.bold('正解！', 36),
        UniversalImage(
          Assets.images.keyWithShadow.path,
          width: 180,
          height: 180,
        ),
        DarkBrownTexts('鍵$pinIdをゲットした。\nMap画面で使ってみよう', 20),
      ],
    );
  }
}
