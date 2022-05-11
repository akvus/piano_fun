import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/data/midi_repository.dart';
import 'package:fun_with_piano/feature/chords/data/note_mapper.dart';
import 'package:fun_with_piano/feature/chords/data/note_repository.dart';

import '../../../_mock/mocked_midi_command.dart';
import '../../../_mock/mocked_midi_packet.dart';

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
      const noteOnCode = 144;
      const noteOffCode = 128;
      const middleCCode = 60;

      test('should emit a note mapped from a $MidiPacket', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([noteOnCode, middleCCode, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emits(NotePosition.middleC),
        );
      });

      test('should throw when $MidiPacket does not match any note', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([noteOnCode, 1148, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emitsError(isA<StateError>()),
        );
      });

      test('should not emit when $MidiPacket is a note off event', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([noteOffCode, middleCCode, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          neverEmits(NotePosition.middleC),
        );
      });
    });

    group('isNoteOnEvent', () {
      test('should return true when bits are 1000xyzw', () async {
        // 10000000
        expect(repository.isNoteOnEvent(144), true);
        // 10001111
        expect(repository.isNoteOnEvent(159), true);
      });

      test('should return false when bits are other than 1000xyzw', () async {
        // 11001111
        expect(repository.isNoteOnEvent(128), false);
        // 00000001
        expect(repository.isNoteOnEvent(1), false);
      });
    });
  });
}
