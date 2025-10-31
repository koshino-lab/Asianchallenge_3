import 'package:flutter/material.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';

class MapPageBottomBar extends ConsumerWidget {
  const MapPageBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final solvedCount = ref.watch(mapPageProvider).ownKeyCount;
    // const solvedCount = 9; // NOTE: UI確認用に変更
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(height: 1, thickness: 1, color: Colors.grey),
        SafeArea(
          minimum: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scaleY: 1.5,
                  child: Assets.images.container.image(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Builder(
                          builder: (context) {
                            final keys = List.generate(
                              solvedCount,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1.0,
                                ),
                                child: Assets.images.keyWithShadow.image(
                                  width: 64,
                                  height: 64,
                                ),
                              ),
                            );

                            const keysPerRow = 5;
                            final firstRowKeys = keys.take(keysPerRow).toList();
                            final secondRowKeys = keys
                                .skip(keysPerRow)
                                .toList();

                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: firstRowKeys,
                                ),
                                if (secondRowKeys.isNotEmpty)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: secondRowKeys,
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          ref.read(mapPageProvider.notifier).useAllKeys();
                          await Navigator.of(context).pushNamed('/problem');
                        },
                        child: UniversalImage(
                          Assets.images.redDecoratedButtonSubmitUse.path,
                          height: 64,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
