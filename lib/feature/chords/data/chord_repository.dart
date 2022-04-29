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

const _baseOctave = 4;
const _nextOctave = _baseOctave + 1;

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
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(note: Note.G, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'Cm',
        notes: [
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'C',
        notes: [
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'C',
        notes: [
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'C7',
        notes: [
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'D',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'Daug',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Ddim',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'D7',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'D',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'E',
        notes: [
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.B, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'E♭',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
    ];

    return _cache!;
  }
}
