import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

enum ChordMatch { matched, partial, failed }

class MatchChordUseCase {
  ChordMatch call({required Chord chord, required List<Note> notes}) {}
}
