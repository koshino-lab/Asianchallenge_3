import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/map_page_bottom_bar.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/positioned_question_pin.dart';
import 'widgets/tutorial_popup.dart';
import 'map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);
    final isImageLoaded = useState(false);
    final image = Image(
      image: AssetImage(Assets.images.map.path),
      fit: BoxFit.cover,
    );

    Future<void> cacheImage() async {
      try {
        await precacheImage(image.image, context);
      } finally {
        isImageLoaded.value = true;
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        cacheImage();

        if (mapPageState.isFirstOpen) {
          if (!context.mounted) return;
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const TutorialPopup(),
          );
          mapPageController.setFirstOpenFalse();
        }
      });
      return null;
    }, [mapPageState.isFirstOpen, mapPageController]);

    return Scaffold(
      backgroundColor: isImageLoaded.value
          ? Styles.pageBackground
          : Styles.contentsColor,
      body: isImageLoaded.value
          ? Stack(
              children: [
                SizedBox(width: double.infinity, child: image),
                PositionedQuestionPin(top: 100, left: 50, pinId: '1'),
                PositionedQuestionPin(top: 200, right: 80, pinId: '2'),
                PositionedQuestionPin(bottom: 150, left: 120, pinId: '3'),
                PositionedQuestionPin(bottom: 50, right: 20, pinId: '4'),
              ],
            )
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}
