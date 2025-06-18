import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/components/map_page_bottom_bar.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/components/ask_question_pin.dart';
import '../../components/tutorial_popup.dart';
import 'map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);
    final pinSize = 80.0;

    useEffect(() {
      if (ref.watch(mapPageProvider).isFirstOpen) {
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
    }, [ref, mapPageController]);

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
            child: AskQuestionPin(
              imageAsset: Assets.images.pin1,
              width: pinSize,
              height: pinSize,
              riddle: MapPageController.mapPins['pin1']!.riddle,
              pinId: 'pin1',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
              isSolved: mapPageState.solvedPinIds.contains('pin1'),
            ),
          ),
          Positioned(
            top: 200,
            right: 80,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin2,
              width: pinSize,
              height: pinSize,
              riddle: MapPageController.mapPins['pin2']!.riddle,
              pinId: 'pin2',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
              isSolved: mapPageState.solvedPinIds.contains('pin2'),
            ),
          ),
          Positioned(
            bottom: 150,
            left: 120,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin3,
              width: pinSize,
              height: pinSize,
              riddle: MapPageController.mapPins['pin3']!.riddle,
              pinId: 'pin3',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
              isSolved: mapPageState.solvedPinIds.contains('pin3'),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin4,
              width: pinSize,
              height: pinSize,
              riddle: MapPageController.mapPins['pin4']!.riddle,
              pinId: 'pin4',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
              isSolved: mapPageState.solvedPinIds.contains('pin4'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}
