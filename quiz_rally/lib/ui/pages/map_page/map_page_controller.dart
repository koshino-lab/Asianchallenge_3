import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/models/map_pin.dart';
import 'package:quiz_rally/cookie_manager/cookie_manager.dart';

part 'map_page_controller.freezed.dart';
part 'map_page_controller.g.dart';

@freezed
class MapPageState with _$MapPageState {
  const factory MapPageState({
    @Default(0) int tutorialPageIndex,
    // ↓cokieで保存したいデータ
    @Default(true) bool isFirstOpen,
    @Default('') String lastSubmissionResult,
    @Default(<String>{}) Set<String> solvedPinIds,
    @Default(<String>[]) List<String> usedKeyIds,
    @Default(0) int ownKeyCount,
    @Default(false) bool isLastQuestionAvailable,
    @Default(false) bool isGameCleared,
  }) = _MapPageState;

  factory MapPageState.fromJson(Map<String, dynamic> json) =>
      _$MapPageStateFromJson(json);
}

final mapPageProvider = StateNotifierProvider<MapPageController, MapPageState>(
  (ref) => MapPageController(),
);

class MapPageController extends StateNotifier<MapPageState> {
  MapPageController() : super(const MapPageState()) {
    _init();
  }

  static const Map<String, MapPin> mapPins = {
    '1': MapPin(riddle: 'これは最初の謎々です。', correctAnswer: '1'),
    '2': MapPin(riddle: 'これは二番目の謎々です。', correctAnswer: '2'),
    '3': MapPin(riddle: 'これは三番目の謎々です。', correctAnswer: '3'),
    '4': MapPin(riddle: 'これは四番目の謎々です。', correctAnswer: '4'),
  };

  void _init() {
    // cookieからデータをloadする. データがない場合は初期化
    final loaded = CookieManager.loadData();
    if (loaded != null) {
      state = MapPageState.fromJson(loaded);
    }
    print('MapPageController initialized');
  }

  void _saveToCookie() {
    CookieManager.saveData(state.toJson());
  }

  void setFirstOpenFalse() {
    state = state.copyWith(isFirstOpen: false);
    _saveToCookie();
  }

  void resetTutorial() {
    state = const MapPageState(
      tutorialPageIndex: 0,
      solvedPinIds: {},
      usedKeyIds: [],
    );
    _saveToCookie();
  }

  void setTutorialPageIndex(int index) {
    state = state.copyWith(tutorialPageIndex: index);
    // チュートリアルインデックスはcookie保存対象外
  }

  bool isCorrectAnswer(String pinId, String answer) {
    final MapPin? pin = mapPins[pinId];
    if (pin == null ||
        answer.toLowerCase() != pin.correctAnswer.toLowerCase()) {
      return false;
    }

    return true;
  }

  void submitPinAnswer(String pinId, String answer) {
    final MapPin? pin = mapPins[pinId];
    if (pin != null) {
      if (isCorrectAnswer(pinId, answer)) {
        state = state.copyWith(
          lastSubmissionResult: '正解！',
          solvedPinIds: {...state.solvedPinIds, pinId},
          ownKeyCount: state.ownKeyCount + 1,
        );
        _saveToCookie();
        print('正解！');
      } else {
        state = state.copyWith(lastSubmissionResult: '不正解！');
        _saveToCookie();
        print('不正解！');
      }
    } else {
      state = state.copyWith(lastSubmissionResult: 'ピンが見つかりません');
      _saveToCookie();
      print('ピンが見つかりません');
    }
  }

  void clearSubmissionResult() {
    state = state.copyWith(lastSubmissionResult: '');
    _saveToCookie();
  }

  int get solvedPinCount => state.solvedPinIds.length;

  void useAllKeys() {
    final ownKeys = state.solvedPinIds.difference(state.usedKeyIds.toSet());
    if (ownKeys.isNotEmpty) {
      state = state.copyWith(
        usedKeyIds: [...state.usedKeyIds, ...ownKeys],
        ownKeyCount: 0,
      );
    }
    final usedKeyCount = state.usedKeyIds.length;
    if (usedKeyCount >= 4) {
      state = state.copyWith(isLastQuestionAvailable: true);
    }
    _saveToCookie();
  }

  /// 最後の問題の回答を判定し、正解ならisGameClearedをtrueにする
  bool checkLastAnswer(String answer) {
    // 正解は「アジア」など、必要に応じて変更
    if (answer.trim() == 'アジア') {
      state = state.copyWith(isGameCleared: true);
      _saveToCookie();
      return true;
    } else {
      return false;
    }
  }
}
