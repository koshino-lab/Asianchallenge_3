import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';
import 'package:quiz_rally/ui/pages/problem_page/LastQuestionSubmitButton.dart';

class ProblemPage extends ConsumerWidget {
  const ProblemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLastQuestionAvailable = ref
        .watch(mapPageProvider)
        .isLastQuestionAvailable;
    final isGameCleared = ref.watch(mapPageProvider).isGameCleared;
    final controller = TextEditingController();
    final usedKeyIds = ref.watch(mapPageProvider).usedKeyIds;

    final isLastQuestionShow = isLastQuestionAvailable && !isGameCleared;

    return Scaffold(
      backgroundColor: Styles.pageBackgroundDark,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Container(
              width: 336,
              height: 540,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets
                        .images
                        .letterDialogRectangleWithWantedAndGoldrect
                        .path,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    if (isLastQuestionShow) ...[
                      // if (true) ...[
                      Image.asset(
                        Assets
                            .images
                            .finalQuestion
                            .path, // ← あなたの画像アセット名に合わせて変更してください
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: '回答を入力',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      LastQuestionSubmitButton(
                        controller: controller,
                        ref: ref,
                        context: context,
                      ),
                    ],
                    if (isGameCleared)
                      const Center(
                        child: Text(
                          'ゲームクリア済みです！',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (!isLastQuestionShow && !isGameCleared)
            Stack(
              alignment: Alignment.center,

              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.images.problemPageFilter.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      color: Colors.transparent, // ※透明なContainerでも必要
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    // Assuming key IDs are 1, 2, 3, 4
                    final keyId = index + 1;
                    final image = usedKeyIds.contains(keyId)
                        ? Assets.images.afterChain
                        : Assets.images.beforeChain;
                    return Transform.rotate(
                      angle: (index % 2 == 0) ? 0.2 : -0.2,
                      child: Image.asset(image.path),
                    );
                  }),
                ),
              ],
            ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
