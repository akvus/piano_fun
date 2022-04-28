import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piano/piano.dart';

part 'chord.freezed.dart';

@freezed
class Chord with _$Chord {
  const factory Chord({
    required String name,
    required List<NotePosition> notes,
  }) = _Chords;
}
