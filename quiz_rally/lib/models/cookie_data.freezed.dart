// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cookie_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CookieData _$CookieDataFromJson(Map<String, dynamic> json) {
  return _CookieData.fromJson(json);
}

/// @nodoc
mixin _$CookieData {
  List<int> get solvedPinIds => throw _privateConstructorUsedError;
  List<int> get usedKeyIds => throw _privateConstructorUsedError;
  bool get isLastQuestionAvailable => throw _privateConstructorUsedError;
  bool get isGameCleared => throw _privateConstructorUsedError;

  /// Serializes this CookieData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CookieData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CookieDataCopyWith<CookieData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CookieDataCopyWith<$Res> {
  factory $CookieDataCopyWith(
    CookieData value,
    $Res Function(CookieData) then,
  ) = _$CookieDataCopyWithImpl<$Res, CookieData>;
  @useResult
  $Res call({
    List<int> solvedPinIds,
    List<int> usedKeyIds,
    bool isLastQuestionAvailable,
    bool isGameCleared,
  });
}

/// @nodoc
class _$CookieDataCopyWithImpl<$Res, $Val extends CookieData>
    implements $CookieDataCopyWith<$Res> {
  _$CookieDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CookieData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solvedPinIds = null,
    Object? usedKeyIds = null,
    Object? isLastQuestionAvailable = null,
    Object? isGameCleared = null,
  }) {
    return _then(
      _value.copyWith(
            solvedPinIds: null == solvedPinIds
                ? _value.solvedPinIds
                : solvedPinIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            usedKeyIds: null == usedKeyIds
                ? _value.usedKeyIds
                : usedKeyIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            isLastQuestionAvailable: null == isLastQuestionAvailable
                ? _value.isLastQuestionAvailable
                : isLastQuestionAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGameCleared: null == isGameCleared
                ? _value.isGameCleared
                : isGameCleared // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CookieDataImplCopyWith<$Res>
    implements $CookieDataCopyWith<$Res> {
  factory _$$CookieDataImplCopyWith(
    _$CookieDataImpl value,
    $Res Function(_$CookieDataImpl) then,
  ) = __$$CookieDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<int> solvedPinIds,
    List<int> usedKeyIds,
    bool isLastQuestionAvailable,
    bool isGameCleared,
  });
}

/// @nodoc
class __$$CookieDataImplCopyWithImpl<$Res>
    extends _$CookieDataCopyWithImpl<$Res, _$CookieDataImpl>
    implements _$$CookieDataImplCopyWith<$Res> {
  __$$CookieDataImplCopyWithImpl(
    _$CookieDataImpl _value,
    $Res Function(_$CookieDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CookieData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? solvedPinIds = null,
    Object? usedKeyIds = null,
    Object? isLastQuestionAvailable = null,
    Object? isGameCleared = null,
  }) {
    return _then(
      _$CookieDataImpl(
        solvedPinIds: null == solvedPinIds
            ? _value._solvedPinIds
            : solvedPinIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        usedKeyIds: null == usedKeyIds
            ? _value._usedKeyIds
            : usedKeyIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        isLastQuestionAvailable: null == isLastQuestionAvailable
            ? _value.isLastQuestionAvailable
            : isLastQuestionAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGameCleared: null == isGameCleared
            ? _value.isGameCleared
            : isGameCleared // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CookieDataImpl implements _CookieData {
  const _$CookieDataImpl({
    final List<int> solvedPinIds = const [],
    final List<int> usedKeyIds = const [],
    this.isLastQuestionAvailable = false,
    this.isGameCleared = false,
  }) : _solvedPinIds = solvedPinIds,
       _usedKeyIds = usedKeyIds;

  factory _$CookieDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CookieDataImplFromJson(json);

  final List<int> _solvedPinIds;
  @override
  @JsonKey()
  List<int> get solvedPinIds {
    if (_solvedPinIds is EqualUnmodifiableListView) return _solvedPinIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_solvedPinIds);
  }

  final List<int> _usedKeyIds;
  @override
  @JsonKey()
  List<int> get usedKeyIds {
    if (_usedKeyIds is EqualUnmodifiableListView) return _usedKeyIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_usedKeyIds);
  }

  @override
  @JsonKey()
  final bool isLastQuestionAvailable;
  @override
  @JsonKey()
  final bool isGameCleared;

  @override
  String toString() {
    return 'CookieData(solvedPinIds: $solvedPinIds, usedKeyIds: $usedKeyIds, isLastQuestionAvailable: $isLastQuestionAvailable, isGameCleared: $isGameCleared)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CookieDataImpl &&
            const DeepCollectionEquality().equals(
              other._solvedPinIds,
              _solvedPinIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._usedKeyIds,
              _usedKeyIds,
            ) &&
            (identical(
                  other.isLastQuestionAvailable,
                  isLastQuestionAvailable,
                ) ||
                other.isLastQuestionAvailable == isLastQuestionAvailable) &&
            (identical(other.isGameCleared, isGameCleared) ||
                other.isGameCleared == isGameCleared));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_solvedPinIds),
    const DeepCollectionEquality().hash(_usedKeyIds),
    isLastQuestionAvailable,
    isGameCleared,
  );

  /// Create a copy of CookieData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CookieDataImplCopyWith<_$CookieDataImpl> get copyWith =>
      __$$CookieDataImplCopyWithImpl<_$CookieDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CookieDataImplToJson(this);
  }
}

abstract class _CookieData implements CookieData {
  const factory _CookieData({
    final List<int> solvedPinIds,
    final List<int> usedKeyIds,
    final bool isLastQuestionAvailable,
    final bool isGameCleared,
  }) = _$CookieDataImpl;

  factory _CookieData.fromJson(Map<String, dynamic> json) =
      _$CookieDataImpl.fromJson;

  @override
  List<int> get solvedPinIds;
  @override
  List<int> get usedKeyIds;
  @override
  bool get isLastQuestionAvailable;
  @override
  bool get isGameCleared;

  /// Create a copy of CookieData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CookieDataImplCopyWith<_$CookieDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
