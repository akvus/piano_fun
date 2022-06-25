import 'package:flutter_test/flutter_test.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';
import 'package:fun_with_piano/feature/chords/domain/match_chord_use_case.dart';

void main() {
  group('$MatchChordUseCase', () {
    final useCase = MatchChordUseCase();

    test('should result in $ChordMatch.matched when matched', () {
      final notes = [
        NotePosition(note: Note.C, octave: 3),
        NotePosition(note: Note.E, octave: 3),
        NotePosition(note: Note.G, octave: 3),
      ];
      final actual = useCase(
        chord: Chord(name: 'Fun', notes: notes),
        notes: notes,
      );

      expect(actual, ChordMatch.matched);
    });

    test(
      'should result in $ChordMatch.matched when provided alternative accidental',
      () {
        final chordNotes = [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3, accidental: Accidental.Flat),
          NotePosition(note: Note.G, octave: 3),
        ];
        final notesToMatch = [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.D, octave: 3, accidental: Accidental.Sharp),
          NotePosition(note: Note.G, octave: 3),
        ];

        final actual = useCase(
          chord: Chord(name: 'Fun', notes: chordNotes),
          notes: notesToMatch,
        );

        expect(actual, ChordMatch.matched);
      },
    );

    test('should result in $ChordMatch.partial when partially matched', () {
      final chordNotes = [
        NotePosition(note: Note.C, octave: 3),
        NotePosition(note: Note.E, octave: 3),
        NotePosition(note: Note.G, octave: 3),
      ];
      final notesToMatch = [
        NotePosition(note: Note.C, octave: 3),
        NotePosition(note: Note.G, octave: 3),
      ];

      final actual = useCase(
        chord: Chord(name: 'Fun', notes: chordNotes),
        notes: notesToMatch,
      );

      expect(actual, ChordMatch.partial);
    });

    test('should result in $ChordMatch.failed when failed', () {
      final chordNotes = [
        NotePosition(note: Note.C, octave: 3),
        NotePosition(note: Note.E, octave: 3),
        NotePosition(note: Note.G, octave: 3),
      ];
      final notesToMatch = [
        NotePosition(note: Note.C, octave: 3),
        NotePosition(note: Note.A, octave: 3),
      ];

      final actual = useCase(
        chord: Chord(name: 'Fun', notes: chordNotes),
        notes: notesToMatch,
      );

      expect(actual, ChordMatch.failed);
    });

    test(
      'should result in $ChordMatch.partial when is partial and have duplicates',
      () {
        final chordNotes = [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.E, octave: 3),
          NotePosition(note: Note.G, octave: 3),
        ];
        final notesToMatch = [
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.C, octave: 3),
          NotePosition(note: Note.G, octave: 3),
        ];

        final actual = useCase(
          chord: Chord(name: 'Fun', notes: chordNotes),
          notes: notesToMatch,
        );

        expect(actual, ChordMatch.partial);
      },
    );
  });
}
