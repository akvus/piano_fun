// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fun_with_piano/feature/chords/domain/match_chord_use_case.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_view_model.dart';
import 'package:piano/piano.dart';

import '../../../_mock/chord_repository.mock.dart';
import '../../../_mock/midi_repository.mock.dart';

void main() {
  group('$ChordsTestPageViewModel', () {
    late MockedMidiRepository mockedMidiRepository;
    late MockedChordRepository mockedChordRepository;
    late MatchChordUseCase matchChordUseCase;

    late ChordsTestPageViewModel viewModel;

    setUp(() {
      mockedMidiRepository = MockedMidiRepository();
      mockedChordRepository = MockedChordRepository();

      matchChordUseCase = MatchChordUseCase();
    });

    group('onInit', () {
      test('should set up a listener to midi setup change', () async {
        final midiDevice = MidiDevice('id', 'name', 'type', false);
        mockedMidiRepository.mockedMidiDevices([midiDevice]);

        final controller = StreamController<String>.broadcast();
        final stream = controller.stream;
        mockedMidiRepository.mockMidiSetupChangeStream(stream);

        // Note: calls onInit()
        viewModel = ChordsTestPageViewModel(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
        );

        expectLater(stream, emits(MidiSetUpChangeEvent.deviceFound.name));

        controller.add(MidiSetUpChangeEvent.deviceFound.name);
      });

      test('should set up a listener to receive notes', () async {
        mockedMidiRepository.mockedMidiDevices([]);

        final controller = StreamController<NotePosition>.broadcast();
        final stream = controller.stream;
        mockedMidiRepository.mockNotesStream(stream);

        // Note: calls onInit()
        viewModel = ChordsTestPageViewModel(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
        );

        expectLater(stream, emits(NotePosition.middleC));

        controller.add(NotePosition.middleC);
      });

      // TODO yeah, I know there should be no TODOs
      // and tests written before the actual code :)
      // TODO should init devices
      // TODO should init connection state
    });

    group('post onInit()', () {
      setUp(() async {
        mockedMidiRepository.mockedMidiDevices([]);
        viewModel = ChordsTestPageViewModel(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
        );
      });

      group('onDevicesUpdated', () {
        // TODO
      });

      group('onNoteReceived', () {
        // TODO
      });

      group('onActionButtonPressed', () {
        // TODO
      });

      group('onDeviceSelected', () {
        test('should set selectedDevice on state', () async {
          final device = MidiDevice('id', 'name', 'type', false);

          viewModel.onDeviceSelected(device);

          await Future.delayed(const Duration(milliseconds: 200), () {});

          expect(viewModel.state.selectedDevice, device);
        });
      });
    });
  });
}
