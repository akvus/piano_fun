import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';

final matchChordUseCaseProvider = Provider.autoDispose(
  (ref) => MatchChordUseCase(),
);

enum ChordMatch { matched, partial, failed }

class MatchChordUseCase {
  ChordMatch call({
    required Chord chord,
    required List<NotePosition> notes,
  }) {
    int noteMatchCount = 0;

    // .toSet deals with duplicates
    for (final note in notes.toSet()) {
      if (chord.notes.contains(note) ||
          chord.notes.contains(note.alternativeAccidental)) {
        noteMatchCount++;
      } else {
        return ChordMatch.failed;
      }
    }

    return noteMatchCount == chord.notes.length
        ? ChordMatch.matched
        : ChordMatch.partial;
  }
}
