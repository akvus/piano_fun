import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

final noteMapperProvider = Provider.autoDispose((ref) => NoteMapper());

class NoteMapper {
  Note map(MidiPacket from) {
    final code = from.data[0];
    // TODO
    return Note(name: 'C1', code: code);
  }
}
