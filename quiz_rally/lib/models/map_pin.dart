import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_pin.freezed.dart';

@freezed
class MapPin with _$MapPin {
  const factory MapPin({
    required String riddle,
    required String correctAnswer,
    @Default('') String hint,
  }) = _MapPin;
}
