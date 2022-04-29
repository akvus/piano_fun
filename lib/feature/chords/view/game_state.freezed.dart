// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameState {
  int get gamesCount => throw _privateConstructorUsedError;
  int get successCount => throw _privateConstructorUsedError;
  CurrentResult get currentResult => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res>;
  $Res call({int gamesCount, int successCount, CurrentResult currentResult});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res> implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  final GameState _value;
  // ignore: unused_field
  final $Res Function(GameState) _then;

  @override
  $Res call({
    Object? gamesCount = freezed,
    Object? successCount = freezed,
    Object? currentResult = freezed,
  }) {
    return _then(_value.copyWith(
      gamesCount: gamesCount == freezed
          ? _value.gamesCount
          : gamesCount // ignore: cast_nullable_to_non_nullable
              as int,
      successCount: successCount == freezed
          ? _value.successCount
          : successCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentResult: currentResult == freezed
          ? _value.currentResult
          : currentResult // ignore: cast_nullable_to_non_nullable
              as CurrentResult,
    ));
  }
}

/// @nodoc
abstract class _$GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$GameStateCopyWith(
          _GameState value, $Res Function(_GameState) then) =
      __$GameStateCopyWithImpl<$Res>;
  @override
  $Res call({int gamesCount, int successCount, CurrentResult currentResult});
}

/// @nodoc
class __$GameStateCopyWithImpl<$Res> extends _$GameStateCopyWithImpl<$Res>
    implements _$GameStateCopyWith<$Res> {
  __$GameStateCopyWithImpl(_GameState _value, $Res Function(_GameState) _then)
      : super(_value, (v) => _then(v as _GameState));

  @override
  _GameState get _value => super._value as _GameState;

  @override
  $Res call({
    Object? gamesCount = freezed,
    Object? successCount = freezed,
    Object? currentResult = freezed,
  }) {
    return _then(_GameState(
      gamesCount: gamesCount == freezed
          ? _value.gamesCount
          : gamesCount // ignore: cast_nullable_to_non_nullable
              as int,
      successCount: successCount == freezed
          ? _value.successCount
          : successCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentResult: currentResult == freezed
          ? _value.currentResult
          : currentResult // ignore: cast_nullable_to_non_nullable
              as CurrentResult,
    ));
  }
}

/// @nodoc

class _$_GameState extends _GameState {
  const _$_GameState(
      {required this.gamesCount,
      required this.successCount,
      required this.currentResult})
      : super._();

  @override
  final int gamesCount;
  @override
  final int successCount;
  @override
  final CurrentResult currentResult;

  @override
  String toString() {
    return 'GameState(gamesCount: $gamesCount, successCount: $successCount, currentResult: $currentResult)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameState &&
            const DeepCollectionEquality()
                .equals(other.gamesCount, gamesCount) &&
            const DeepCollectionEquality()
                .equals(other.successCount, successCount) &&
            const DeepCollectionEquality()
                .equals(other.currentResult, currentResult));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gamesCount),
      const DeepCollectionEquality().hash(successCount),
      const DeepCollectionEquality().hash(currentResult));

  @JsonKey(ignore: true)
  @override
  _$GameStateCopyWith<_GameState> get copyWith =>
      __$GameStateCopyWithImpl<_GameState>(this, _$identity);
}

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final int gamesCount,
      required final int successCount,
      required final CurrentResult currentResult}) = _$_GameState;
  const _GameState._() : super._();

  @override
  int get gamesCount => throw _privateConstructorUsedError;
  @override
  int get successCount => throw _privateConstructorUsedError;
  @override
  CurrentResult get currentResult => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GameStateCopyWith<_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
