import 'dart:math';

import 'package:flutter/material.dart';
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
        name: 'C',
        notes: [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3),
          NotePosition(note: Note.G, octave: 3),
        ],
      ),
      Chord(
        name: 'Cm',
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
      Chord(
        name: 'D',
        notes: [
          NotePosition(note: Note.D, octave: 3),
          NotePosition(note: Note.F, octave: 3, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: 3),
        ],
      ),
      Chord(
        name: 'Dm',
        notes: [
          NotePosition(note: Note.D, octave: 3),
          NotePosition(note: Note.F, octave: 3),
          NotePosition(note: Note.A, octave: 3),
        ],
      ),
      Chord(
        name: 'E',
        notes: [
          NotePosition(note: Note.E, octave: 3),
          NotePosition(note: Note.G, octave: 3, accidental: Accidental.Sharp),
          NotePosition(note: Note.B, octave: 3),
        ],
      ),
      Chord(
        name: 'E♭',
        notes: [
          NotePosition(note: Note.E, octave: 3, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: 3),
          NotePosition(note: Note.B, octave: 3, accidental: Accidental.Flat),
        ],
      ),
    ];

    return _cache!;
  }
}
