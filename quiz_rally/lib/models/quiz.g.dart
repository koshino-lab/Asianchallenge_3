// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuizImpl _$$QuizImplFromJson(Map<String, dynamic> json) => _$QuizImpl(
  quiz: json['quiz'] as String,
  type: (json['type'] as num).toInt(),
  hint: json['hint'] as String? ?? '',
);

Map<String, dynamic> _$$QuizImplToJson(_$QuizImpl instance) =>
    <String, dynamic>{
      'quiz': instance.quiz,
      'type': instance.type,
      'hint': instance.hint,
    };
