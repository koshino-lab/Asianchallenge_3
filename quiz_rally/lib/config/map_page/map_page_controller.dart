import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'map_page_controller.freezed.dart';

@freezed
class MapPageState with _$MapPageState {
  const factory MapPageState({
    @Default(false) bool isTutorialShown,
    @Default(0) int tutorialPageIndex,
  }) = _MapPageState;
}

final mapPageProvider = StateNotifierProvider<MapPageController, MapPageState>(
  (ref) => MapPageController(),
);

class MapPageController extends StateNotifier<MapPageState> {
  MapPageController() : super(const MapPageState());

  void toggleTutorial() {
    state = state.copyWith(isTutorialShown: !state.isTutorialShown);
  }

  void resetTutorial() {
    state = const MapPageState(isTutorialShown: false, tutorialPageIndex: 0);
  }

  void setTutorialPageIndex(int index) {
    state = state.copyWith(tutorialPageIndex: index);
  }
}
