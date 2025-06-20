import 'package:flutter/material.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/solved_contents.dart';

class SolvedDialog {
  static Future<String?> show(BuildContext context, String pinId) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 336,
                height: 360,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.images.letterDialogSquare.path),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: SolvedContents(pinId: pinId),
              ),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  height: 50,
                  width: 50,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child: UniversalImage(Assets.images.closeRedButton.path),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
