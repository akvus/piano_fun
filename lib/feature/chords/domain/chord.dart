import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

part 'chord.freezed.dart';

@freezed
class Chord with _$Chord {
  const factory Chord({
    required String name,
    required List<Note> notes,
  }) = _Chords;
}
