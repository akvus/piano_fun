import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_command/flutter_midi_command_messages.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/data/midi_repository.dart';
import 'package:piano_chords_test/feature/chords/data/note_repository.dart';

final noteMapperProvider = Provider.autoDispose((ref) => NoteMapper(
      ref.read(noteRepositoryProvider),
    ));

class NoteMapper {
  NoteMapper(this._noteRepository);

  final NoteRepository _noteRepository;

  NotePosition map(MidiPacket from) {
    final code = from.data[noteCodePositionAtMidiData];

    final note = _noteRepository.find(code);
    if (note == null) {
      throw Exception('Unknown note code');
    }

    return note;
  }
}
