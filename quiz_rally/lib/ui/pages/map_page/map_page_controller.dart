import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/models/map_pin.dart';
import 'package:quiz_rally/cookie_manager/cookie_manager.dart';
import 'package:quiz_rally/models/quiz.dart';
import 'package:quiz_rally/services/quiz_service.dart';
import 'package:quiz_rally/services/user_service.dart';

part 'map_page_controller.freezed.dart';
part 'map_page_controller.g.dart';

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
  MapPageController() : super(MapPageState()) {
    _init();
  }

  final _quizService = QuizService();
  final _userService = UserService();

  static const Map<String, MapPin> mapPins = {
    '1': MapPin(
      riddle: 'これは最初の謎々です。',
      correctAnswer: '__photo_submission__',
      hint: '数字の1だよ',
    ),
    '2': MapPin(riddle: 'これは二番目の謎々です。', correctAnswer: '2', hint: '数字の2だよ'),
    '3': MapPin(riddle: 'これは三番目の謎々です。', correctAnswer: '3', hint: '数字の3だよ'),
    '4': MapPin(riddle: 'これは四番目の謎々です。', correctAnswer: '4', hint: '数字の4だよ'),
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
    state = MapPageState(
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

  // bool isCorrectAnswer(String pinId, String answer) {
  //   final MapPin? pin = mapPins[pinId];
  //   if (pin == null ||
  //       answer.toLowerCase() != pin.correctAnswer.toLowerCase()) {
  //     return false;
  //   }

  //   return true;
  // }

  Future<bool> checkAnswer(int pinId, String answer) async {
    if (await isCorrectAnswer(pinId, answer)) {
      state = state.copyWith(
        solvedPinIds: {...state.solvedPinIds, pinId},
        ownKeyCount: state.ownKeyCount + 1,
      );
      _saveToCookie();
      print('正解！');
      return true;
    } else {
      print('不正解！');
      return false;
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

  Future<void> createUserId() async {
    final userId = await _userService.createUserId();
    state = state.copyWith(userId: userId);
  }

  Future<List<int>> getProgress() async {
    if (state.userId == '') {
      await createUserId();
    }
    final userId = state.userId;
    return _userService.getProgress(userId);
  }

  Future<Quiz> getQuiz(int quizId) async {
    return _quizService.getQuiz(quizId.toString());
  }

  Future<bool> isCorrectAnswer(int quizId, String answer) async {
    if (state.userId == '') {
      await createUserId();
    }
    final userId = state.userId;
    print(
      "Checking answer for quizId: $quizId, answer: $answer, userId: $userId",
    );
    final checkAnsResult = await _quizService.checkAnswer(
      quizId,
      answer,
      userId,
    );
    if (checkAnsResult == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<double> getCorrectAnswerRate(int quizId) async {
    return _quizService.getCorrectAnswerRate(quizId);
  }
}
