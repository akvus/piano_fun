import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';

final randomizerProvider = Provider((ref) => Random());

final chordRepositoryProvider = Provider.autoDispose(
  (ref) => ChordRepository(
    ref.read(randomizerProvider),
  ),
);

class ChordRepository {
  ChordRepository(
    this._randomizer,
  );

  final Random _randomizer;

  List<Chord>? _cache;

  Chord get random => all[_randomizer.nextInt(all.length)];

  List<Chord> get all {
    _cache ??= [
      // TODO fill in xDD
      Chord(
        name: 'C major',
        notes: [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3),
          NotePosition(note: Note.G, octave: 3),
        ],
      ),
      Chord(
        name: 'C minor',
        notes: [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: 3),
        ],
      ),
      Chord(
        name: 'C7',
        notes: [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3),
          NotePosition(note: Note.G, octave: 3),
          NotePosition(note: Note.B, octave: 3),
        ],
      ),
    ];

    return _cache!;
  }
}
