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
                      const Text(
                        '最後の問題:\n"アジアのチャレンジ"の合言葉は？',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
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
          if (!isLastQuestionAvailable || !isGameCleared)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.problemPageFilterWithBrown.path,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
