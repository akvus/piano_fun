import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/note_repository.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';

final randomizerProvider = Provider((ref) => Random());

final chordRepositoryProvider = Provider.autoDispose(
  (ref) => ChordRepository(
    ref.read(randomizerProvider),
    ref.read(noteRepositoryProvider),
  ),
);

class ChordRepository {
  ChordRepository(
    this._randomizer,
    this._noteRepository,
  );

  final Random _randomizer;
  final NoteRepository _noteRepository;

  List<Chord>? _cache;

  Chord get random => all[_randomizer.nextInt(all.length)];

  List<Chord> get all {
    if (_cache == null) {
      final notes = _noteRepository.all;

      _cache = [
        // TODO fill in xDD
        Chord(
          name: 'C major',
          notes: [
            notes[48]!,
            notes[52]!,
            notes[55]!,
          ],
        ),
        Chord(
          name: 'C minor',
          notes: [
            notes[48]!,
            notes[51]!,
            notes[55]!,
          ],
        ),
        Chord(
          name: 'C7',
          notes: [
            notes[48]!,
            notes[52]!,
            notes[55]!,
            notes[57]!,
          ],
        ),
      ];
    }

    return _cache!;
  }
}
