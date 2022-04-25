// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chords_test_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChordsTestPageModel {
  List<MidiDevice> get devices => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChordsTestPageModelCopyWith<ChordsTestPageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChordsTestPageModelCopyWith<$Res> {
  factory $ChordsTestPageModelCopyWith(
          ChordsTestPageModel value, $Res Function(ChordsTestPageModel) then) =
      _$ChordsTestPageModelCopyWithImpl<$Res>;
  $Res call({List<MidiDevice> devices});
}

/// @nodoc
class _$ChordsTestPageModelCopyWithImpl<$Res>
    implements $ChordsTestPageModelCopyWith<$Res> {
  _$ChordsTestPageModelCopyWithImpl(this._value, this._then);

  final ChordsTestPageModel _value;
  // ignore: unused_field
  final $Res Function(ChordsTestPageModel) _then;

  @override
  $Res call({
    Object? devices = freezed,
  }) {
    return _then(_value.copyWith(
      devices: devices == freezed
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<MidiDevice>,
    ));
  }
}

/// @nodoc
abstract class _$ChordsTestePageModelCopyWith<$Res>
    implements $ChordsTestPageModelCopyWith<$Res> {
  factory _$ChordsTestePageModelCopyWith(_ChordsTestePageModel value,
          $Res Function(_ChordsTestePageModel) then) =
      __$ChordsTestePageModelCopyWithImpl<$Res>;
  @override
  $Res call({List<MidiDevice> devices});
}

/// @nodoc
class __$ChordsTestePageModelCopyWithImpl<$Res>
    extends _$ChordsTestPageModelCopyWithImpl<$Res>
    implements _$ChordsTestePageModelCopyWith<$Res> {
  __$ChordsTestePageModelCopyWithImpl(
      _ChordsTestePageModel _value, $Res Function(_ChordsTestePageModel) _then)
      : super(_value, (v) => _then(v as _ChordsTestePageModel));

  @override
  _ChordsTestePageModel get _value => super._value as _ChordsTestePageModel;

  @override
  $Res call({
    Object? devices = freezed,
  }) {
    return _then(_ChordsTestePageModel(
      devices: devices == freezed
          ? _value.devices
          : devices // ignore: cast_nullable_to_non_nullable
              as List<MidiDevice>,
    ));
  }
}

/// @nodoc

class _$_ChordsTestePageModel implements _ChordsTestePageModel {
  const _$_ChordsTestePageModel({required final List<MidiDevice> devices})
      : _devices = devices;

  final List<MidiDevice> _devices;
  @override
  List<MidiDevice> get devices {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devices);
  }

  @override
  String toString() {
    return 'ChordsTestPageModel(devices: $devices)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChordsTestePageModel &&
            const DeepCollectionEquality().equals(other.devices, devices));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(devices));

  @JsonKey(ignore: true)
  @override
  _$ChordsTestePageModelCopyWith<_ChordsTestePageModel> get copyWith =>
      __$ChordsTestePageModelCopyWithImpl<_ChordsTestePageModel>(
          this, _$identity);
}

abstract class _ChordsTestePageModel implements ChordsTestPageModel {
  const factory _ChordsTestePageModel(
      {required final List<MidiDevice> devices}) = _$_ChordsTestePageModel;

  @override
  List<MidiDevice> get devices => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChordsTestePageModelCopyWith<_ChordsTestePageModel> get copyWith =>
      throw _privateConstructorUsedError;
}
