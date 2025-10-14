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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          DarkBrownTexts.bold('Q U I Z  $pinId', 48),
          const SizedBox(height: 4),
          DarkBrownTexts.bold('不正解！', 36),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Column(
              children: [
                DarkBrownTexts('ヒント：', 20),
                const SizedBox(height: 8),
                Text(
                  hint.isEmpty ? 'なし' : hint,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF4A3C28),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
      ),
    );
  }
}
