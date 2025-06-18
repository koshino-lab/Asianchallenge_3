import 'package:freezed_annotation/freezed_annotation.dart';

part 'cookie_data.freezed.dart';
part 'cookie_data.g.dart';

@freezed
class CookieData with _$CookieData {
  const factory CookieData({
    @Default([]) List<int> solvedPinIds,
    @Default([]) List<int> usedKeyIds,
    @Default(false) bool isLastQuestionAvailable,
    @Default(false) bool isGameCleared,
  }) = _CookieData;

  factory CookieData.fromJson(Map<String, dynamic> json) =>
      _$CookieDataFromJson(json);
}
