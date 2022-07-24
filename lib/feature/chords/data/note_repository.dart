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

      map[21] = NotePosition(note: Note.A, octave: 0);
      map[22] =
          NotePosition(note: Note.A, octave: 0, accidental: Accidental.Sharp);
      map[23] = NotePosition(note: Note.B, octave: 0);

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

      map[108] = NotePosition(note: Note.C, octave: 8);

      _cache = map;
    }

    return _cache!;
  }

  NotePosition? find(int code) =>
      all.entries.firstWhere((entry) => entry.key == code).value;
}
