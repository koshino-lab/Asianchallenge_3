// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CookieDataImpl _$$CookieDataImplFromJson(Map<String, dynamic> json) =>
    _$CookieDataImpl(
      solvedPinIds:
          (json['solvedPinIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      usedKeyIds:
          (json['usedKeyIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      isLastQuestionAvailable:
          json['isLastQuestionAvailable'] as bool? ?? false,
      isGameCleared: json['isGameCleared'] as bool? ?? false,
    );

Map<String, dynamic> _$$CookieDataImplToJson(_$CookieDataImpl instance) =>
    <String, dynamic>{
      'solvedPinIds': instance.solvedPinIds,
      'usedKeyIds': instance.usedKeyIds,
      'isLastQuestionAvailable': instance.isLastQuestionAvailable,
      'isGameCleared': instance.isGameCleared,
    };
