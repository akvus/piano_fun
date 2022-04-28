import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

enum ChordMatch { matched, partial, failed }

class MatchChordUseCase {
  ChordMatch call({required Chord chord, required List<Note> notes}) {
    int matchesCount = 0;

    for (final note in notes) {
      if (chord.notes.contains(note)) {
        matchesCount++;
      } else {
        return ChordMatch.failed;
      }
    }

    return matchesCount == chord.notes.length
        ? ChordMatch.matched
        : ChordMatch.partial;
  }
}
