import 'package:flutter/widgets.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';

class WrongContents extends StatelessWidget {
  final String pinId;
  final String hint;

  const WrongContents({super.key, required this.pinId, required this.hint});

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
      ],
    );
  }
}
