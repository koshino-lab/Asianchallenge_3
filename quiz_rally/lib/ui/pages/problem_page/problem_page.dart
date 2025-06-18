import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';

class ProblemPage extends ConsumerWidget {
  const ProblemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLastQuestionAvailable = ref
        .watch(mapPageProvider)
        .isLastQuestionAvailable;
    final isGameCleared = ref.watch(mapPageProvider).isGameCleared;
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('鎖の問題')),
      body: Container(
        color: Styles.primaryColor,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            if (isLastQuestionAvailable && !isGameCleared) ...[
              const SizedBox(height: 32),
              const Text(
                '最後の問題: "アジアのチャレンジ"の合言葉は？',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: '回答を入力',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final answer = controller.text.trim();
                    final isCorrect = ref
                        .read(mapPageProvider.notifier)
                        .checkLastAnswer(answer);
                    if (isCorrect) {
                      await Navigator.of(
                        context,
                      ).pushReplacementNamed('/success');
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('不正解です。')));
                    }
                  },
                  child: const Text('送信'),
                ),
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
    );
  }
}
