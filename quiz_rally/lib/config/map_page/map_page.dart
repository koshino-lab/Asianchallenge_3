import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/components/map_page_bottom_bar.dart';
import '../../ui/components/tutorial_popup.dart';
import 'map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

class MapPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapPageState = ref.watch(mapPageProvider);
    final mapPageController = ref.read(mapPageProvider.notifier);

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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.map.provider(),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/problem');
              },
              child: const Text('問題へすすむ'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MapPageBottomBar(),
    );
  }
}
