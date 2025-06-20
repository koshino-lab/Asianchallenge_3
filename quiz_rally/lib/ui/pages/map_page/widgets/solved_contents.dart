import 'package:flutter/widgets.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class SolvedContents extends StatelessWidget {
  final String pinId;

  const SolvedContents({super.key, required this.pinId});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10),
        DarkBrownTexts.bold('Q U I Z  $pinId', 48),
        UniversalImage(
          Assets.images.keyWithShadow.path,
          width: 180,
          height: 180,
        ),
        DarkBrownTexts('すでに正解済みだ', 20),
      ],
    );
  }
}
