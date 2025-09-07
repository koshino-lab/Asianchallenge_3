import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz.freezed.dart';
part 'quiz.g.dart';

@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String quiz,
    required int type,
    @Default('') String hint,
  }) = _Quiz;
  const Quiz._();

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
} //
