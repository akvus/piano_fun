import 'package:flutter_test/flutter_test.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/domain/match_chord_use_case.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

void main() {
  group('$MatchChordUseCase', () {
    final useCase = MatchChordUseCase();

    test('should result in $ChordMatch.matched when matched', () {
      final notes = [
        const Note(name: 'note1', code: 1),
        const Note(name: 'note2', code: 2),
        const Note(name: 'note3', code: 3),
      ];
      final actual = useCase(
        chord: Chord(name: 'Fun', notes: notes),
        notes: notes,
      );

      expect(actual, ChordMatch.matched);
    });

    test('should result in $ChordMatch.partial when partially matched', () {
      final chordNotes = [
        const Note(name: 'note1', code: 1),
        const Note(name: 'note2', code: 2),
        const Note(name: 'note3', code: 3),
      ];
      final notesToMatch = [
        const Note(name: 'note1', code: 1),
        const Note(name: 'note3', code: 3),
      ];

      final actual = useCase(
        chord: Chord(name: 'Fun', notes: chordNotes),
        notes: notesToMatch,
      );

      expect(actual, ChordMatch.partial);
    });

    test('should result in $ChordMatch.failed when failed', () {
      final chordNotes = [
        const Note(name: 'note1', code: 1),
        const Note(name: 'note2', code: 2),
        const Note(name: 'note3', code: 3),
      ];
      final notesToMatch = [
        const Note(name: 'note1', code: 1),
        const Note(name: 'note2', code: 2),
        const Note(name: 'note4', code: 4),
      ];

      final actual = useCase(
        chord: Chord(name: 'Fun', notes: chordNotes),
        notes: notesToMatch,
      );

      expect(actual, ChordMatch.failed);
    });
  });
}
