import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../ui/components/tutorial_popup.dart';
import 'map_page_controller.dart';

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
      appBar: AppBar(title: Text('マップ')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/problem');
            },
            child: const Text('問題へすすむ'),
          ),
        ],
      ),
    );
  }
}
