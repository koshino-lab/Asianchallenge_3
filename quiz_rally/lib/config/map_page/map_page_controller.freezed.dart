// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MapPin {
  String get riddle => throw _privateConstructorUsedError;
  String get correctAnswer => throw _privateConstructorUsedError;

  /// Create a copy of MapPin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapPinCopyWith<MapPin> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapPinCopyWith<$Res> {
  factory $MapPinCopyWith(MapPin value, $Res Function(MapPin) then) =
      _$MapPinCopyWithImpl<$Res, MapPin>;
  @useResult
  $Res call({String riddle, String correctAnswer});
}

/// @nodoc
class _$MapPinCopyWithImpl<$Res, $Val extends MapPin>
    implements $MapPinCopyWith<$Res> {
  _$MapPinCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapPin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? riddle = null, Object? correctAnswer = null}) {
    return _then(
      _value.copyWith(
            riddle: null == riddle
                ? _value.riddle
                : riddle // ignore: cast_nullable_to_non_nullable
                      as String,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapPinImplCopyWith<$Res> implements $MapPinCopyWith<$Res> {
  factory _$$MapPinImplCopyWith(
    _$MapPinImpl value,
    $Res Function(_$MapPinImpl) then,
  ) = __$$MapPinImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String riddle, String correctAnswer});
}

/// @nodoc
class __$$MapPinImplCopyWithImpl<$Res>
    extends _$MapPinCopyWithImpl<$Res, _$MapPinImpl>
    implements _$$MapPinImplCopyWith<$Res> {
  __$$MapPinImplCopyWithImpl(
    _$MapPinImpl _value,
    $Res Function(_$MapPinImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapPin
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? riddle = null, Object? correctAnswer = null}) {
    return _then(
      _$MapPinImpl(
        riddle: null == riddle
            ? _value.riddle
            : riddle // ignore: cast_nullable_to_non_nullable
                  as String,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MapPinImpl implements _MapPin {
  const _$MapPinImpl({required this.riddle, required this.correctAnswer});

  @override
  final String riddle;
  @override
  final String correctAnswer;

  @override
  String toString() {
    return 'MapPin(riddle: $riddle, correctAnswer: $correctAnswer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapPinImpl &&
            (identical(other.riddle, riddle) || other.riddle == riddle) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, riddle, correctAnswer);

  /// Create a copy of MapPin
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapPinImplCopyWith<_$MapPinImpl> get copyWith =>
      __$$MapPinImplCopyWithImpl<_$MapPinImpl>(this, _$identity);
}

abstract class _MapPin implements MapPin {
  const factory _MapPin({
    required final String riddle,
    required final String correctAnswer,
  }) = _$MapPinImpl;

  @override
  String get riddle;
  @override
  String get correctAnswer;

  /// Create a copy of MapPin
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapPinImplCopyWith<_$MapPinImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MapPageState {
  bool get isTutorialShown => throw _privateConstructorUsedError;
  int get tutorialPageIndex => throw _privateConstructorUsedError;
  Map<String, MapPin> get mapPins => throw _privateConstructorUsedError;
  String get lastSubmissionResult => throw _privateConstructorUsedError;

  /// Create a copy of MapPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapPageStateCopyWith<MapPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapPageStateCopyWith<$Res> {
  factory $MapPageStateCopyWith(
    MapPageState value,
    $Res Function(MapPageState) then,
  ) = _$MapPageStateCopyWithImpl<$Res, MapPageState>;
  @useResult
  $Res call({
    bool isTutorialShown,
    int tutorialPageIndex,
    Map<String, MapPin> mapPins,
    String lastSubmissionResult,
  });
}

/// @nodoc
class _$MapPageStateCopyWithImpl<$Res, $Val extends MapPageState>
    implements $MapPageStateCopyWith<$Res> {
  _$MapPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTutorialShown = null,
    Object? tutorialPageIndex = null,
    Object? mapPins = null,
    Object? lastSubmissionResult = null,
  }) {
    return _then(
      _value.copyWith(
            isTutorialShown: null == isTutorialShown
                ? _value.isTutorialShown
                : isTutorialShown // ignore: cast_nullable_to_non_nullable
                      as bool,
            tutorialPageIndex: null == tutorialPageIndex
                ? _value.tutorialPageIndex
                : tutorialPageIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            mapPins: null == mapPins
                ? _value.mapPins
                : mapPins // ignore: cast_nullable_to_non_nullable
                      as Map<String, MapPin>,
            lastSubmissionResult: null == lastSubmissionResult
                ? _value.lastSubmissionResult
                : lastSubmissionResult // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MapPageStateImplCopyWith<$Res>
    implements $MapPageStateCopyWith<$Res> {
  factory _$$MapPageStateImplCopyWith(
    _$MapPageStateImpl value,
    $Res Function(_$MapPageStateImpl) then,
  ) = __$$MapPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isTutorialShown,
    int tutorialPageIndex,
    Map<String, MapPin> mapPins,
    String lastSubmissionResult,
  });
}

/// @nodoc
class __$$MapPageStateImplCopyWithImpl<$Res>
    extends _$MapPageStateCopyWithImpl<$Res, _$MapPageStateImpl>
    implements _$$MapPageStateImplCopyWith<$Res> {
  __$$MapPageStateImplCopyWithImpl(
    _$MapPageStateImpl _value,
    $Res Function(_$MapPageStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MapPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isTutorialShown = null,
    Object? tutorialPageIndex = null,
    Object? mapPins = null,
    Object? lastSubmissionResult = null,
  }) {
    return _then(
      _$MapPageStateImpl(
        isTutorialShown: null == isTutorialShown
            ? _value.isTutorialShown
            : isTutorialShown // ignore: cast_nullable_to_non_nullable
                  as bool,
        tutorialPageIndex: null == tutorialPageIndex
            ? _value.tutorialPageIndex
            : tutorialPageIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        mapPins: null == mapPins
            ? _value._mapPins
            : mapPins // ignore: cast_nullable_to_non_nullable
                  as Map<String, MapPin>,
        lastSubmissionResult: null == lastSubmissionResult
            ? _value.lastSubmissionResult
            : lastSubmissionResult // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$MapPageStateImpl implements _MapPageState {
  const _$MapPageStateImpl({
    this.isTutorialShown = false,
    this.tutorialPageIndex = 0,
    final Map<String, MapPin> mapPins = const {},
    this.lastSubmissionResult = '',
  }) : _mapPins = mapPins;

  @override
  @JsonKey()
  final bool isTutorialShown;
  @override
  @JsonKey()
  final int tutorialPageIndex;
  final Map<String, MapPin> _mapPins;
  @override
  @JsonKey()
  Map<String, MapPin> get mapPins {
    if (_mapPins is EqualUnmodifiableMapView) return _mapPins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_mapPins);
  }

  @override
  @JsonKey()
  final String lastSubmissionResult;

  @override
  String toString() {
    return 'MapPageState(isTutorialShown: $isTutorialShown, tutorialPageIndex: $tutorialPageIndex, mapPins: $mapPins, lastSubmissionResult: $lastSubmissionResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapPageStateImpl &&
            (identical(other.isTutorialShown, isTutorialShown) ||
                other.isTutorialShown == isTutorialShown) &&
            (identical(other.tutorialPageIndex, tutorialPageIndex) ||
                other.tutorialPageIndex == tutorialPageIndex) &&
            const DeepCollectionEquality().equals(other._mapPins, _mapPins) &&
            (identical(other.lastSubmissionResult, lastSubmissionResult) ||
                other.lastSubmissionResult == lastSubmissionResult));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isTutorialShown,
    tutorialPageIndex,
    const DeepCollectionEquality().hash(_mapPins),
    lastSubmissionResult,
  );

  /// Create a copy of MapPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      __$$MapPageStateImplCopyWithImpl<_$MapPageStateImpl>(this, _$identity);
}

abstract class _MapPageState implements MapPageState {
  const factory _MapPageState({
    final bool isTutorialShown,
    final int tutorialPageIndex,
    final Map<String, MapPin> mapPins,
    final String lastSubmissionResult,
  }) = _$MapPageStateImpl;

  @override
  bool get isTutorialShown;
  @override
  int get tutorialPageIndex;
  @override
  Map<String, MapPin> get mapPins;
  @override
  String get lastSubmissionResult;

  /// Create a copy of MapPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapPageStateImplCopyWith<_$MapPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
