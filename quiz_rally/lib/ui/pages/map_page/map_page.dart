import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/map_page_bottom_bar.dart';
import 'package:quiz_rally/ui/pages/map_page/widgets/ask_question_pin.dart';
import 'widgets/tutorial_popup.dart';
import 'map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);

    useEffect(() {
      if (mapPageState.isFirstOpen) {
        Future.microtask(() async {
          await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const TutorialPopup(),
          );
          mapPageController.setFirstOpenFalse();
        });
      }
      return null;
    }, [mapPageState.isFirstOpen, mapPageController]);

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
          PositionedQuestionPin(top: 100, left: 50, pinId: 'pin1'),
          PositionedQuestionPin(top: 200, right: 80, pinId: 'pin2'),
          PositionedQuestionPin(bottom: 150, left: 120, pinId: 'pin3'),
          PositionedQuestionPin(bottom: 50, right: 20, pinId: 'pin4'),
        ],
      ),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}
