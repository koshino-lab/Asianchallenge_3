import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/models/map_pin.dart';

part 'map_page_controller.freezed.dart';

@freezed
class MapPageState with _$MapPageState {
  const factory MapPageState({
    @Default(false) bool isTutorialShown,
    @Default(0) int tutorialPageIndex,
    @Default({
      'pin1': MapPin(riddle: 'これは最初の謎々です。', correctAnswer: '答え1'),
      'pin2': MapPin(riddle: 'これは二番目の謎々です。', correctAnswer: '答え2'),
      'pin3': MapPin(riddle: 'これは三番目の謎々です。', correctAnswer: '答え3'),
      'pin4': MapPin(riddle: 'これは四番目の謎々です。', correctAnswer: '答え4'),
    })
    Map<String, MapPin> mapPins,
    @Default('') String lastSubmissionResult,
    @Default(<String>{}) Set<String> solvedPinIds,
    @Default(0) int usedKeyCount,
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
    state = const MapPageState(
      isTutorialShown: false,
      tutorialPageIndex: 0,
      solvedPinIds: {},
      usedKeyCount: 0,
    );
  }

  void setTutorialPageIndex(int index) {
    state = state.copyWith(tutorialPageIndex: index);
  }

  void submitPinAnswer(String pinId, String answer) {
    final MapPin? pin = state.mapPins[pinId];
    if (pin != null) {
      if (answer.toLowerCase() == pin.correctAnswer.toLowerCase()) {
        if (!state.solvedPinIds.contains(pinId)) {
          state = state.copyWith(
            lastSubmissionResult: '正解！',
            solvedPinIds: {...state.solvedPinIds, pinId},
          );
        } else {
          state = state.copyWith(lastSubmissionResult: '正解！');
        }
        print('正解！');
      } else {
        state = state.copyWith(lastSubmissionResult: '不正解！');
        print('不正解！');
      }
    } else {
      state = state.copyWith(lastSubmissionResult: 'ピンが見つかりません');
      print('ピンが見つかりません');
    }
  }

  void clearSubmissionResult() {
    state = state.copyWith(lastSubmissionResult: '');
  }

  int get solvedPinCount => state.solvedPinIds.length;

  void useAllKeys() {
    final ownKeys = state.solvedPinIds.length - state.usedKeyCount;
    if (ownKeys > 0) {
      state = state.copyWith(
        solvedPinIds: {},
        usedKeyCount: state.usedKeyCount + ownKeys,
      );
    }
  }
}
