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
  const MapPage({super.key});

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

    // ==== マップ画像の元サイズ ====
    const double mapWidth = 1598;
    const double mapHeight = 3072;

    // ==== 画面幅に合わせてスケール計算 ====
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scale = screenWidth / mapWidth;
    final double displayedHeight = mapHeight * scale;

    // ==== ピンの元座標 ====
    const pinPositions = [
      {'id': 1, 'x': 655.0, 'y': 1200.0},
      {'id': 2, 'x': 1250.0, 'y': 920.0},
      {'id': 3, 'x': 650.0, 'y': 130.0},
      {'id': 4, 'x': 320.0, 'y': 280.0},
      {'id': 5, 'x': 1080.0, 'y': 420.0},
      {'id': 6, 'x': 1250.0, 'y': 400.0},
      {'id': 7, 'x': 5.0, 'y': 870.0},
      {'id': 8, 'x': 850.0, 'y': 530.0},
      {'id': 9, 'x': 20.0, 'y': 1300.0},
    ];

    return Scaffold(
      backgroundColor:
          isImageLoaded.value ? Styles.pageBackground : Styles.contentsColor,
      body: isImageLoaded.value
          ? SingleChildScrollView( // 高さが大きいのでスクロール対応
              child: Center(
                child: SizedBox(
                  width: screenWidth,
                  height: displayedHeight,
                  child: Stack(
                    children: [
                      Image.asset(
                        Assets.images.map.path,
                        width: screenWidth,
                        height: displayedHeight,
                        fit: BoxFit.cover,
                      ),

                      // ピンをスケールして配置
                      for (final pin in pinPositions)
                        PositionedQuestionPin(
                          left: pin['x']! * scale,
                          top: pin['y']! * scale,
                          pinId: pin['id']!.toInt(),
                        ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}