import 'package:flutter/material.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPageBottomBar extends StatelessWidget {
  const MapPageBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 1, color: Colors.grey),
        SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: Assets.images.container.image(),
          ),
        ),
      ],
    );
  }
}
