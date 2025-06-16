import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/components/map_page_bottom_bar.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import '../../ui/components/tutorial_popup.dart';
import 'map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);
    final pinSize = 80.0;

    useEffect(() {
      if (!mapPageState.isTutorialShown) {
        Future.microtask(() async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const TutorialPopup(),
          );
          mapPageController.toggleTutorial();
        });
      }
      return null;
    }, [mapPageState.isTutorialShown]);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.map.provider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            child: UniversalImage(
              Assets.images.pin1,
              width: pinSize,
              height: pinSize,
            ),
          ),
          Positioned(
            top: 200,
            right: 80,
            child: UniversalImage(
              Assets.images.pin2,
              width: pinSize,
              height: pinSize,
            ),
          ),
          Positioned(
            bottom: 150,
            left: 120,
            child: UniversalImage(
              Assets.images.pin3,
              width: pinSize,
              height: pinSize,
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: UniversalImage(
              Assets.images.pin4,
              width: pinSize,
              height: pinSize,
            ),
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     await Navigator.of(context).pushNamed('/problem');
          //   },
          //   child: const Text('問題へすすむ'),
          // ),
        ],
      ),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}
