import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/data/note_mapper.dart';
import 'package:fun_with_piano/feature/chords/data/note_repository.dart';

import '../../../_mock/mocked_midi_packet.dart';

void main() {
  group('$NoteMapper', () {
    late NoteMapper noteMapper;
    late NoteRepository noteRepository;

    setUp(() {
      noteRepository = NoteRepository();
      noteMapper = NoteMapper(noteRepository);
    });

    group('map', () {
      final mockedMidiPacket = MockedMidiPacket();

      setUp(() {
        reset(mockedMidiPacket);
      });

      test('map maps from $MidiPacket to $NotePosition', () {
        mockedMidiPacket.mockData(Uint8List.fromList([1, 48, 3]));

        final actual = noteMapper.map(mockedMidiPacket);

        expect(actual, NotePosition(note: Note.C, octave: 3));
      });

      test('should throw an exception when a note is not found', () {
        mockedMidiPacket.mockData(Uint8List.fromList([1, 148, 3]));

        expect(
          () => noteMapper.map(mockedMidiPacket),
          throwsA(isA<StateError>()),
        );
      });
    });
  });
}
