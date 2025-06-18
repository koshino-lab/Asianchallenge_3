import 'package:flutter/material.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';

class ProblemPage extends ConsumerWidget {
  const ProblemPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usedKeyCount = ref.watch(mapPageProvider).usedKeyCount;
    return Scaffold(
      appBar: AppBar(title: Text('鎖の問題')),
      body: Container(
        color: Styles.primaryColor,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            if (usedKeyCount >= 4)
              ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/success');
                },
                child: const Text('成功画面にすすむ'),
              ),
          ],
        ),
      ),
    );
  }
}
