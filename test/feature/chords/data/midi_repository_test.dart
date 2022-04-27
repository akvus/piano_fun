import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano_chords_test/feature/chords/data/midi_repository.dart';
import 'package:piano_chords_test/feature/chords/data/note_mapper.dart';
import 'package:piano_chords_test/feature/chords/data/note_repository.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

import '../../../_mock/midi_command.mock.dart';
import '../../../_mock/midi_packet.mock.dart';

void main() {
  group('$MidiRepository', () {
    late MockedMidiCommand mockedMidiCommand;
    late NoteRepository noteRepository;
    late NoteMapper noteMapper;

    late MidiRepository repository;

    setUp(() async {
      mockedMidiCommand = MockedMidiCommand();
      noteRepository = NoteRepository();
      noteMapper = NoteMapper(noteRepository);

      repository = MidiRepository(mockedMidiCommand, noteMapper);
    });

    group('notesStream', () {
      test('should return a note mapped from a $MidiPacket', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([0, 48, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emits(const Note(
            name: 'C3',
            code: 48,
          )),
        );
      });

      test('should throw when $MidiPacket does not match any note', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([0, 1148, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emitsError(isA<StateError>()),
        );
      });
    });
  });
}
