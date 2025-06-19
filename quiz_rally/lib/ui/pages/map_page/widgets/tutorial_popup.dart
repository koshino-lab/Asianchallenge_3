import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/ui/components/theme_text.dart';
import 'package:quiz_rally/ui/components/universal_image.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page_controller.dart';
import 'package:quiz_rally/gen/assets.gen.dart';

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
      description: '『おれの財宝か？欲しけりゃくれてやる・・・。\n探せ！高専の全てをそこに置いてきた』\n\n世はまさに大津幡時代！！',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(mapPageProvider).tutorialPageIndex;
    final mapPageController = ref.read(mapPageProvider.notifier);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        width: 336,
        height: 540,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.letterDialogRectangleWithWanted.path,
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (pageIndex > 0)
                    Container(
                      padding: const EdgeInsets.only(left: 70),
                      width: 85,
                      child: InkWell(
                        onTap: () => mapPageController.setTutorialPageIndex(
                          pageIndex - 1,
                        ),
                        child: UniversalImage(
                          Assets.images.rectangleBack.path,
                          height: 25,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 85),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pageData.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pageIndex == index
                                ? Styles.primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (pageIndex < _pageData.length - 1)
                    InkWell(
                      onTap: () =>
                          mapPageController.setTutorialPageIndex(pageIndex + 1),
                      child: UniversalImage(
                        Assets.images.rightTrapezoidWithNext.path,
                        height: 25,
                      ),
                    )
                  else
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: UniversalImage(
                        Assets.images.rightTrapezoidWithStart.path,
                        height: 25,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 120),
        SizedBox(width: 180, child: image),
        const SizedBox(height: 24),
        SizedBox(width: 245, child: DarkBrownTexts(description, 20)),
      ],
    );
  }
}
