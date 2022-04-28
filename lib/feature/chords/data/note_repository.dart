import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';

final noteRepositoryProvider = Provider.autoDispose((ref) => NoteRepository());

const notesInOctave = 12;

class NoteRepository {
  Map<int, NotePosition>? _cache;

  Map<int, NotePosition> get all {
    if (_cache == null) {
      final map = <int, NotePosition>{};

      const startWithOctave = 3;
      const octaveCount = 2;
      const c3Code = 48;

      for (int i = 0; i < octaveCount; i++) {
        final octave = startWithOctave + i;
        int noteCode = c3Code + i * notesInOctave;

        map[noteCode++] = NotePosition(note: Note.C, octave: octave);
        map[noteCode++] = NotePosition(
          note: Note.C,
          octave: octave,
          accidental: Accidental.Sharp,
        );
        map[noteCode++] = NotePosition(note: Note.D, octave: octave);
        map[noteCode++] = NotePosition(
          note: Note.D,
          octave: octave,
          accidental: Accidental.Sharp,
        );
        map[noteCode++] = NotePosition(note: Note.E, octave: octave);
        map[noteCode++] = NotePosition(note: Note.F, octave: octave);
        map[noteCode++] = NotePosition(
          note: Note.F,
          octave: octave,
          accidental: Accidental.Sharp,
        );
        map[noteCode++] = NotePosition(note: Note.G, octave: octave);
        map[noteCode++] = NotePosition(
          note: Note.G,
          octave: octave,
          accidental: Accidental.Sharp,
        );
        map[noteCode++] = NotePosition(note: Note.A, octave: octave);
        map[noteCode++] = NotePosition(
          note: Note.A,
          octave: octave,
          accidental: Accidental.Sharp,
        );
        map[noteCode++] = NotePosition(note: Note.B, octave: octave);
      }

      _cache = map;
    }

    return _cache!;
  }

  NotePosition? find(int code) =>
      all.entries.firstWhere((entry) => entry.key == code).value;
}
