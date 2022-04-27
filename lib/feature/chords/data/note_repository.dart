import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

final noteRepositoryProvider = Provider.autoDispose((ref) => NoteRepository());

enum NoteName {
  c3,
  c3s,
  d3,
  d3s,
  e3,
  f3,
  f3s,
  g3,
  g3s,
  a3,
  a3s,
  b3,
  c4,
  c4s,
  d4,
  d4s,
  e4,
  f4,
  f4s,
  g4,
  g4s,
  a4,
  a4s,
  b4,
  c5,
}

class NoteRepository {
  Map<NoteName, Note>? _cache;

  Map<NoteName, Note> get all {
    if (_cache == null) {
      final map = <NoteName, Note>{};
      int code = 48;
      for (var i = 0; i < NoteName.values.length; i++) {
        final noteName = NoteName.values[i];
        map[noteName] = Note(name: noteName.name.toUpperCase(), code: code++);
      }
      _cache = map;
    }

    return _cache!;
  }

  Note? find(int code) => all.values.firstWhere((note) => note.code == code);
}
