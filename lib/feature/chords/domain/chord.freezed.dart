// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chord.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Chord {
  String get name => throw _privateConstructorUsedError;
  List<NotePosition> get notes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChordCopyWith<Chord> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChordCopyWith<$Res> {
  factory $ChordCopyWith(Chord value, $Res Function(Chord) then) =
      _$ChordCopyWithImpl<$Res>;
  $Res call({String name, List<NotePosition> notes});
}

/// @nodoc
class _$ChordCopyWithImpl<$Res> implements $ChordCopyWith<$Res> {
  _$ChordCopyWithImpl(this._value, this._then);

  final Chord _value;
  // ignore: unused_field
  final $Res Function(Chord) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NotePosition>,
    ));
  }
}

/// @nodoc
abstract class _$ChordsCopyWith<$Res> implements $ChordCopyWith<$Res> {
  factory _$ChordsCopyWith(_Chords value, $Res Function(_Chords) then) =
      __$ChordsCopyWithImpl<$Res>;
  @override
  $Res call({String name, List<NotePosition> notes});
}

/// @nodoc
class __$ChordsCopyWithImpl<$Res> extends _$ChordCopyWithImpl<$Res>
    implements _$ChordsCopyWith<$Res> {
  __$ChordsCopyWithImpl(_Chords _value, $Res Function(_Chords) _then)
      : super(_value, (v) => _then(v as _Chords));

  @override
  _Chords get _value => super._value as _Chords;

  @override
  $Res call({
    Object? name = freezed,
    Object? notes = freezed,
  }) {
    return _then(_Chords(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NotePosition>,
    ));
  }
}

/// @nodoc

class _$_Chords implements _Chords {
  const _$_Chords({required this.name, required final List<NotePosition> notes})
      : _notes = notes;

  @override
  final String name;
  final List<NotePosition> _notes;
  @override
  List<NotePosition> get notes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  String toString() {
    return 'Chord(name: $name, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chords &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.notes, notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(notes));

  @JsonKey(ignore: true)
  @override
  _$ChordsCopyWith<_Chords> get copyWith =>
      __$ChordsCopyWithImpl<_Chords>(this, _$identity);
}

abstract class _Chords implements Chord {
  const factory _Chords(
      {required final String name,
      required final List<NotePosition> notes}) = _$_Chords;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<NotePosition> get notes => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChordsCopyWith<_Chords> get copyWith => throw _privateConstructorUsedError;
}
