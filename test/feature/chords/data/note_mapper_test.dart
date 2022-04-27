import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano_chords_test/feature/chords/data/note_mapper.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

void main() {
  group('$NoteMapper', () {
    late NoteMapper noteMapper;

    setUp(() {
      noteMapper = NoteMapper();
    });

    test('map maps from $MidiPacket to $Note', () {
      // TODO finish and add a mocking FW or fakes
      final midiPacket = MidiPacket([10, 22, 33], timestamp, device);
    });
  });
}
