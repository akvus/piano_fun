import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';

final noteRepositoryProvider = Provider.autoDispose((ref) => NoteRepository());

const notesInOctave = 12;

class NoteRepository {
  Map<int, NotePosition>? _cache;

  Map<int, NotePosition> get all {
    if (_cache == null) {
      final map = <int, NotePosition>{};

      const startWithOctave = 1;
      const octaveCount = 7;
      const c1Code = 24;

      // Note: this skips A0, A0#, B0 and C8 - which could be a problem
      // if other features are added to the app
      for (int i = 0; i < octaveCount; i++) {
        final octave = startWithOctave + i;
        int noteCode = c1Code + i * notesInOctave;

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
