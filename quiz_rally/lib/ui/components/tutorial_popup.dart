import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/config/map_page/map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';

class TutorialPopup extends ConsumerWidget {
  const TutorialPopup({super.key});

  static final _pageData = [
    (
      image: Assets.images.story1.image(),
      description: '富、名声、力 かつてこの世の全てを手に入れた男 ”高専王・Mr.K”',
    ),
    (
      image: Assets.images.story2.image(),
      description: '彼の退職際に放った一言は全高専生を森へと駆り立てた',
    ),
    (
      image: Assets.images.story3.image(),
      description: '『おれの財宝か？欲しけりゃくれてやる・・・。探せ！高専の全てをそこに置いてきた』\n世はまさに大津幡時代！！',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(mapPageProvider).tutorialPageIndex;
    final mapPageController = ref.read(mapPageProvider.notifier);

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SizedBox(
        width: 320,
        height: 420,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _TutorialPage(
                    key: ValueKey(pageIndex),
                    image: _pageData[pageIndex].image,
                    description: _pageData[pageIndex].description,
                  ),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pageData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pageIndex == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (pageIndex > 0)
                    TextButton(
                      onPressed: () =>
                          mapPageController.setTutorialPageIndex(pageIndex - 1),
                      child: const Text('前へ'),
                    )
                  else
                    const SizedBox(width: 64),
                  if (pageIndex < _pageData.length - 1)
                    TextButton(
                      onPressed: () =>
                          mapPageController.setTutorialPageIndex(pageIndex + 1),
                      child: const Text('次へ'),
                    )
                  else
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('はじめる'),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _TutorialPage extends StatelessWidget {
  final Widget image;
  final String description;
  const _TutorialPage({
    Key? key,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //child: UniversalImage(Assets.images.icon),
        // Image.asset(image_path, width: 160, height: 160, fit: BoxFit.cover),
        SizedBox(width: 160, height: 160, child: image),
        const SizedBox(height: 24),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
