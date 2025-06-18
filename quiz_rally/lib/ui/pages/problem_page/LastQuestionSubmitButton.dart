import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';

class LastQuestionSubmitButton extends StatelessWidget {
  final TextEditingController controller;
  final WidgetRef ref;
  final BuildContext context;

  const LastQuestionSubmitButton({
    required this.controller,
    required this.ref,
    required this.context,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final answer = controller.text.trim();
        final isCorrect = ref
            .read(mapPageProvider.notifier)
            .checkLastAnswer(answer);
        if (isCorrect) {
          await Navigator.of(this.context).pushReplacementNamed('/success');
        } else {
          ScaffoldMessenger.of(
            this.context,
          ).showSnackBar(const SnackBar(content: Text('不正解です。')));
        }
      },
      child: const Text('送信'),
    );
  }
}
