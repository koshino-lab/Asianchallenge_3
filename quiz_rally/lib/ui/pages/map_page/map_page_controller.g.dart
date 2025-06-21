// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_page_controller.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapPageStateImpl _$$MapPageStateImplFromJson(Map<String, dynamic> json) =>
    _$MapPageStateImpl(
      tutorialPageIndex: (json['tutorialPageIndex'] as num?)?.toInt() ?? 0,
      isFirstOpen: json['isFirstOpen'] as bool? ?? true,
      solvedPinIds:
          (json['solvedPinIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toSet() ??
          const <int>{},
      usedKeyIds:
          (json['usedKeyIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      ownKeyCount: (json['ownKeyCount'] as num?)?.toInt() ?? 0,
      isLastQuestionAvailable:
          json['isLastQuestionAvailable'] as bool? ?? false,
      isGameCleared: json['isGameCleared'] as bool? ?? false,
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$$MapPageStateImplToJson(_$MapPageStateImpl instance) =>
    <String, dynamic>{
      'tutorialPageIndex': instance.tutorialPageIndex,
      'isFirstOpen': instance.isFirstOpen,
      'solvedPinIds': instance.solvedPinIds.toList(),
      'usedKeyIds': instance.usedKeyIds,
      'ownKeyCount': instance.ownKeyCount,
      'isLastQuestionAvailable': instance.isLastQuestionAvailable,
      'isGameCleared': instance.isGameCleared,
      'userId': instance.userId,
    };
