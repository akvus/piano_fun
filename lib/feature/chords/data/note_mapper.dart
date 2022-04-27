import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/note_repository.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

final noteMapperProvider = Provider.autoDispose((ref) => NoteMapper(
      ref.read(noteRepositoryProvider),
    ));

class NoteMapper {
  NoteMapper(this._noteRepository);

  final NoteRepository _noteRepository;

  Note map(MidiPacket from) {
    final code = from.data[1];

    final note = _noteRepository.find(code);
    if (note == null) {
      throw Exception('Unknown note code');
    }

    return note;
  }
}
