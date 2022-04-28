import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';

final matchChordUseCaseProvider =
    Provider.autoDispose((ref) => MatchChordUseCase());

enum ChordMatch { matched, partial, failed }

class MatchChordUseCase {
  ChordMatch call({required Chord chord, required List<NotePosition> notes}) {
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
