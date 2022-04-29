import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/data/midi_repository.dart';
import 'package:fun_with_piano/feature/chords/data/note_mapper.dart';
import 'package:fun_with_piano/feature/chords/data/note_repository.dart';

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
          ..mockData(Uint8List.fromList([128, 48, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emits(NotePosition(note: Note.C, octave: 3)),
        );
      });

      test('should throw when $MidiPacket does not match any note', () {
        final mockedMidiPacket = MockedMidiPacket()
          ..mockData(Uint8List.fromList([128, 1148, 2]));

        final stream = Stream.value(mockedMidiPacket);
        mockedMidiCommand.mockOnMidiDataReceived(stream);

        expectLater(
          repository.notesStream,
          emitsError(isA<StateError>()),
        );
      });
    });

    group('isNoteOnEvent', () {
      test('should return true when bits are 1000xyzw', () async {
        // 10000000
        expect(repository.isNoteOnEvent(128), true);
        // 10001111
        expect(repository.isNoteOnEvent(143), true);
      });
      test('should return false when bits are other than 1000xyzw', () async {
        // 11001111
        expect(repository.isNoteOnEvent(207), false);
        // 00000001
        expect(repository.isNoteOnEvent(1), false);
      });
    });
  });
}
