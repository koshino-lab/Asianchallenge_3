import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/cookie_manager/cookie_manager.dart';

part 'map_page_controller.freezed.dart';
part 'map_page_controller.g.dart';

const Map<int, List<String>> stampQRCodes = {
  1: ['https://qrly.org/X0bAqb'],
  2: ['https://qrly.org/mMl2Gy'],
  3: ['https://qrly.org/tPHJAn'],
  4: ['https://qrly.org/0VocYO'],
  5: ['https://qrly.org/C2DCeO'],
  6: ['https://qrly.org/6qRpSY'],
  7: ['https://qrly.org/QFrjgf'],
  8: ['https://qrly.org/cPWTCe'],
  9: ['https://qrly.org/GdhTBB'],
};




@freezed
class MapPageState with _$MapPageState {
  const factory MapPageState({
    @Default(0) int tutorialPageIndex,
    // ↓cokieで保存したいデータ
    @Default(true) bool isFirstOpen,
    @Default(<int>{}) Set<int> solvedPinIds,
    @Default(<int>[]) List<int> usedKeyIds,
    @Default(0) int ownKeyCount,
    @Default(false) bool isLastQuestionAvailable,
    @Default(false) bool isGameCleared,
    @Default('') String userId,
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

  String checkQRCode(String code) {
    final qrCodeContent = code.trim();
    print(qrCodeContent.toString());
    int? pinId;

    stampQRCodes.forEach((key, value) {
      if (value.contains(qrCodeContent)) {
        pinId = key;
      }
    });

    if (pinId != null) {
      if (state.solvedPinIds.contains(pinId)) {
        return '使用済みのQRコードです(スタンプ$pinIdはすでに獲得済みです)';
      } else {
        state = state.copyWith(
          solvedPinIds: {...state.solvedPinIds, pinId!},
          ownKeyCount: state.ownKeyCount + 1,
        );
        _saveToCookie();
        return 'スタンプ$pinIdゲット！鍵$pinIdゲット';
      }
    } else {
      return 'スタンプラリーに関係ないQRコードです';
    }
  }

  void clearSubmissionResult() {
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
    if (usedKeyCount >= 9) {
      state = state.copyWith(isLastQuestionAvailable: true);
    }
    _saveToCookie();
  }

  /// 最後の問題の回答を判定し、正解ならisGameClearedをtrueにする
  bool checkLastAnswer(String answer) {
    // TODO: ユーザーに最後の問題の答えを確認する
    if (answer.trim() == '高専の森') {
      state = state.copyWith(isGameCleared: true);
      _saveToCookie();
      return true;
    } else {
      return false;
    }
  }
}
