import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';

final matchChordUseCaseProvider = Provider.autoDispose(
  (ref) => MatchChordUseCase(),
);

enum ChordMatch { matched, partial, failed }

class MatchChordUseCase {
  ChordMatch call({required Chord chord, required List<NotePosition> notes}) {
    for (final note in notes) {
      if (!chord.notes.contains(note) &&
          !chord.notes.contains(note.alternativeAccidental)) {
        return ChordMatch.failed;
      }
    }

    int chordMatches = 0;
    for (final note in chord.notes) {
      if (notes.contains(note) || notes.contains(note.alternativeAccidental)) {
        chordMatches++;
      }
    }

    return chordMatches == chord.notes.length
        ? ChordMatch.matched
        : ChordMatch.partial;
  }
}
