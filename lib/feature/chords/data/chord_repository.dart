import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';

final randomizerProvider = Provider((ref) => Random());

final chordRepositoryProvider = Provider.autoDispose(
  (ref) => ChordRepository(
    ref.read(randomizerProvider),
  ),
);

const _baseOctave = 4;
const _nextOctave = _baseOctave + 1;

class ChordRepository {
  ChordRepository(this._randomizer);

  final Random _randomizer;

  List<Chord>? _cache;

  Chord get random => all[_randomizer.nextInt(all.length)];

  List<Chord> get all {
    _cache ??= [
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
        name: 'Caug',
        notes: [
          NotePosition(note: Note.C, octave: _baseOctave),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Cdim',
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
        name: 'C#/D♭',
        notes: [
          NotePosition(
              note: Note.D, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'C#/D♭m',
        notes: [
          NotePosition(
              note: Note.C, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'C#/D♭aug',
        notes: [
          NotePosition(
              note: Note.D, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(note: Note.A, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'C#/D♭dim',
        notes: [
          NotePosition(
              note: Note.C, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(note: Note.G, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'C#/D♭7',
        notes: [
          NotePosition(
              note: Note.D, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.B, octave: _baseOctave),
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
        name: 'Dm',
        notes: [
          NotePosition(note: Note.D, octave: _baseOctave),
          NotePosition(note: Note.F, octave: _baseOctave),
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
        name: 'D#/E♭',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'D#/E♭m',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'D#/E♭aug',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(note: Note.B, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'D#/E♭dim',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.A, octave: _baseOctave) // == B♭♭
        ],
      ),
      Chord(
        name: 'D#/E♭7',
        notes: [
          NotePosition(
              note: Note.E, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Flat),
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
        name: 'Em',
        notes: [
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(note: Note.B, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'Eaug',
        notes: [
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.C, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Edim',
        notes: [
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'E7',
        notes: [
          NotePosition(note: Note.E, octave: _baseOctave),
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'F',
        notes: [
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Fm',
        notes: [
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.C, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Faug',
        notes: [
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Fdim',
        notes: [
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.B, octave: _baseOctave),
        ],
      ),
      Chord(
        name: 'F7',
        notes: [
          NotePosition(note: Note.F, octave: _baseOctave),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(
              note: Note.E, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'F#/G♭',
        notes: [
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'F#/G♭m',
        notes: [
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'F#/G♭aug',
        notes: [
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.D, octave: _nextOctave), // == C##
        ],
      ),
      Chord(
        name: 'F#/G♭dim',
        notes: [
          NotePosition(
              note: Note.F, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'G',
        notes: [
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Gm',
        notes: [
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.D, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Gaug',
        notes: [
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Gdim',
        notes: [
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'G',
        notes: [
          NotePosition(note: Note.G, octave: _baseOctave),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(note: Note.F, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'G#/A♭',
        notes: [
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(
              note: Note.E, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'G#/A♭m',
        notes: [
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'G#/A♭aug',
        notes: [
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(note: Note.E, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'G#/A♭dim',
        notes: [
          NotePosition(
              note: Note.G, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'G#/A♭7',
        notes: [
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(
              note: Note.E, octave: _nextOctave, accidental: Accidental.Flat),
          NotePosition(
              note: Note.G, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'A',
        notes: [
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.E, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Am',
        notes: [
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(note: Note.E, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'Aaug',
        notes: [
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.E, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Adim',
        notes: [
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(note: Note.C, octave: _nextOctave),
          NotePosition(
              note: Note.E, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'A7',
        notes: [
          NotePosition(note: Note.A, octave: _baseOctave),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.E, octave: _nextOctave),
          NotePosition(note: Note.G, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'A#/B♭',
        notes: [
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(note: Note.F, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'A#/B♭m',
        notes: [
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(note: Note.F, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'A#/B♭aug',
        notes: [
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(
              note: Note.F, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'A#/B♭dim',
        notes: [
          NotePosition(
              note: Note.A, octave: _baseOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.C, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.E, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'A#/B♭7',
        notes: [
          NotePosition(
              note: Note.B, octave: _baseOctave, accidental: Accidental.Flat),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(note: Note.F, octave: _nextOctave),
          NotePosition(
              note: Note.A, octave: _nextOctave, accidental: Accidental.Flat),
        ],
      ),
      Chord(
        name: 'B',
        notes: [
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.F, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Bm',
        notes: [
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(
              note: Note.F, octave: _nextOctave, accidental: Accidental.Sharp),
        ],
      ),
      Chord(
        name: 'Baug',
        notes: [
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.G, octave: _nextOctave), // G == Fx
        ],
      ),
      Chord(
        name: 'Bdim',
        notes: [
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(note: Note.D, octave: _nextOctave),
          NotePosition(note: Note.F, octave: _nextOctave),
        ],
      ),
      Chord(
        name: 'B7',
        notes: [
          NotePosition(note: Note.B, octave: _baseOctave),
          NotePosition(
              note: Note.D, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(
              note: Note.F, octave: _nextOctave, accidental: Accidental.Sharp),
          NotePosition(note: Note.A, octave: _nextOctave),
        ],
      ),
    ];

    return _cache!;
  }
}
