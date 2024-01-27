// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LocationState {
  TemperatureUnit get currentUnit => throw _privateConstructorUsedError;
  String? get currentLocation => throw _privateConstructorUsedError;
  CurrentForecastResponse? get currentForecast =>
      throw _privateConstructorUsedError;
  DailyForecastResponse? get dailyForecast =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationStateCopyWith<LocationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationStateCopyWith<$Res> {
  factory $LocationStateCopyWith(
          LocationState value, $Res Function(LocationState) then) =
      _$LocationStateCopyWithImpl<$Res, LocationState>;
  @useResult
  $Res call(
      {TemperatureUnit currentUnit,
      String? currentLocation,
      CurrentForecastResponse? currentForecast,
      DailyForecastResponse? dailyForecast});
}

/// @nodoc
class _$LocationStateCopyWithImpl<$Res, $Val extends LocationState>
    implements $LocationStateCopyWith<$Res> {
  _$LocationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUnit = null,
    Object? currentLocation = freezed,
    Object? currentForecast = freezed,
    Object? dailyForecast = freezed,
  }) {
    return _then(_value.copyWith(
      currentUnit: null == currentUnit
          ? _value.currentUnit
          : currentUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      currentForecast: freezed == currentForecast
          ? _value.currentForecast
          : currentForecast // ignore: cast_nullable_to_non_nullable
              as CurrentForecastResponse?,
      dailyForecast: freezed == dailyForecast
          ? _value.dailyForecast
          : dailyForecast // ignore: cast_nullable_to_non_nullable
              as DailyForecastResponse?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationStateImplCopyWith<$Res>
    implements $LocationStateCopyWith<$Res> {
  factory _$$LocationStateImplCopyWith(
          _$LocationStateImpl value, $Res Function(_$LocationStateImpl) then) =
      __$$LocationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TemperatureUnit currentUnit,
      String? currentLocation,
      CurrentForecastResponse? currentForecast,
      DailyForecastResponse? dailyForecast});
}

/// @nodoc
class __$$LocationStateImplCopyWithImpl<$Res>
    extends _$LocationStateCopyWithImpl<$Res, _$LocationStateImpl>
    implements _$$LocationStateImplCopyWith<$Res> {
  __$$LocationStateImplCopyWithImpl(
      _$LocationStateImpl _value, $Res Function(_$LocationStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUnit = null,
    Object? currentLocation = freezed,
    Object? currentForecast = freezed,
    Object? dailyForecast = freezed,
  }) {
    return _then(_$LocationStateImpl(
      currentUnit: null == currentUnit
          ? _value.currentUnit
          : currentUnit // ignore: cast_nullable_to_non_nullable
              as TemperatureUnit,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      currentForecast: freezed == currentForecast
          ? _value.currentForecast
          : currentForecast // ignore: cast_nullable_to_non_nullable
              as CurrentForecastResponse?,
      dailyForecast: freezed == dailyForecast
          ? _value.dailyForecast
          : dailyForecast // ignore: cast_nullable_to_non_nullable
              as DailyForecastResponse?,
    ));
  }
}

/// @nodoc

class _$LocationStateImpl implements _LocationState {
  const _$LocationStateImpl(
      {this.currentUnit = TemperatureUnit.fahrenheit,
      this.currentLocation,
      this.currentForecast,
      this.dailyForecast});

  @override
  @JsonKey()
  final TemperatureUnit currentUnit;
  @override
  final String? currentLocation;
  @override
  final CurrentForecastResponse? currentForecast;
  @override
  final DailyForecastResponse? dailyForecast;

  @override
  String toString() {
    return 'LocationState(currentUnit: $currentUnit, currentLocation: $currentLocation, currentForecast: $currentForecast, dailyForecast: $dailyForecast)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationStateImpl &&
            (identical(other.currentUnit, currentUnit) ||
                other.currentUnit == currentUnit) &&
            (identical(other.currentLocation, currentLocation) ||
                other.currentLocation == currentLocation) &&
            (identical(other.currentForecast, currentForecast) ||
                other.currentForecast == currentForecast) &&
            (identical(other.dailyForecast, dailyForecast) ||
                other.dailyForecast == dailyForecast));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentUnit, currentLocation,
      currentForecast, dailyForecast);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      __$$LocationStateImplCopyWithImpl<_$LocationStateImpl>(this, _$identity);
}

abstract class _LocationState implements LocationState {
  const factory _LocationState(
      {final TemperatureUnit currentUnit,
      final String? currentLocation,
      final CurrentForecastResponse? currentForecast,
      final DailyForecastResponse? dailyForecast}) = _$LocationStateImpl;

  @override
  TemperatureUnit get currentUnit;
  @override
  String? get currentLocation;
  @override
  CurrentForecastResponse? get currentForecast;
  @override
  DailyForecastResponse? get dailyForecast;
  @override
  @JsonKey(ignore: true)
  _$$LocationStateImplCopyWith<_$LocationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
