import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/components/map_page_bottom_bar.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/components/tappable_pin.dart';
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
      if (!ref.watch(mapPageProvider).isTutorialShown) {
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
    }, [ref, mapPageController]);

    useEffect(() {
      final currentLastSubmissionResult = ref
          .watch(mapPageProvider)
          .lastSubmissionResult;
      if (currentLastSubmissionResult.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(currentLastSubmissionResult),
            duration: const Duration(seconds: 2),
          ),
        );
        // Clear the message after showing it
        mapPageController.clearSubmissionResult();
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
              riddle: mapPageState.mapPins['pin1']!.riddle,
              pinId: 'pin1',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
            ),
          ),
          Positioned(
            top: 200,
            right: 80,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin2,
              width: pinSize,
              height: pinSize,
              riddle: mapPageState.mapPins['pin2']!.riddle,
              pinId: 'pin2',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
            ),
          ),
          Positioned(
            bottom: 150,
            left: 120,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin3,
              width: pinSize,
              height: pinSize,
              riddle: mapPageState.mapPins['pin3']!.riddle,
              pinId: 'pin3',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: AskQuestionPin(
              imageAsset: Assets.images.pin4,
              width: pinSize,
              height: pinSize,
              riddle: mapPageState.mapPins['pin4']!.riddle,
              pinId: 'pin4',
              onSubmitAnswer: (pinId, answer) {
                mapPageController.submitPinAnswer(pinId, answer);
              },
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
