import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/config/map_page/map_page.dart';

class TopPageRoute extends ConsumerWidget {
  TopPageRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final double iconSize = size.shortestSide / 15;
    return Scaffold(
      body: Stack(
        children: [MapPage()],
      ),
    );
  }
}
