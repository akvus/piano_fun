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

  Chord get random => all[_randomizer.nextInt(all.length - 1)];

  List<Chord> get all {
    if (_cache == null) {
      final notes = _noteRepository.all;

      _cache = [
        // TODO fill in xDD
        Chord(
          name: 'C maj',
          notes: [
            notes[NoteName.c3]!,
            notes[NoteName.e3]!,
            notes[NoteName.g3]!,
          ],
        ),
        Chord(
          name: 'C min',
          notes: [
            notes[NoteName.c3]!,
            notes[NoteName.d3s]!,
            notes[NoteName.g3]!,
          ],
        ),
      ];
    }

    return _cache!;
  }
}
