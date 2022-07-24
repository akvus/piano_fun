// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';
import 'package:fun_with_piano/feature/chords/domain/match_chord_use_case.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_model.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_notifier.dart';
import 'package:fun_with_piano/feature/chords/view/game_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:piano/piano.dart';
import 'package:time/time.dart';

import '../../../_mock/fakes_setup.dart';
import '../../../_mock/mocked_chord_repository.dart';
import '../../../_mock/mocked_flutter_midi.dart';
import '../../../_mock/mocked_midi_repository.dart';

void main() {
  group('$ChordsTestPageNotifier', () {
    late MockedMidiRepository mockedMidiRepository;
    late MockedChordRepository mockedChordRepository;
    late MockedFlutterMidi mockedFlutterMidi;
    late MatchChordUseCase matchChordUseCase;

    late ChordsTestPageNotifier notifier;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      registerAllCallbacks();
    });

    setUp(() {
      mockedMidiRepository = MockedMidiRepository();
      mockedChordRepository = MockedChordRepository();
      mockedFlutterMidi = MockedFlutterMidi();
      mockedFlutterMidi.mockPrepare();

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
        notifier = ChordsTestPageNotifier(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
          mockedFlutterMidi,
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
        notifier = ChordsTestPageNotifier(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
          mockedFlutterMidi,
        );

        expectLater(stream, emits(NotePosition.middleC));

        controller.add(NotePosition.middleC);
      });
    });

    group('post onInit()', () {
      setUp(() async {
        mockedMidiRepository.mockedMidiDevices([]);
        notifier = ChordsTestPageNotifier(
          mockedMidiRepository,
          mockedChordRepository,
          matchChordUseCase,
          mockedFlutterMidi,
        );
      });

      group('onDeviceSelected', () {
        test('should set selectedDevice on state', () async {
          final device = MidiDevice('id', 'name', 'type', false);

          notifier.onDeviceSelected(device);

          await Future.delayed(200.milliseconds, () {});

          expect(notifier.state.selectedDevice, device);
        });
      });

      group('OnActionButtonPressed', () {
        test(
          'should connect a device when not connected and a device is selected',
          () async {
            final midiDevice = MidiDevice(
              'id',
              'name',
              'type',
              false,
            );
            const expectedChord = Chord(name: 'name', notes: []);

            notifier.state = notifier.state.copyWith(
              devices: [midiDevice],
              selectedDevice: midiDevice,
              connectionStatus: ConnectionStatus.disconnected,
            );

            mockedMidiRepository.mockConnect();
            mockedChordRepository.mockRnadom(expectedChord);

            await notifier.onActionButtonPressed();

            verify(() => mockedMidiRepository.connect(midiDevice)).called(1);

            expect(
              notifier.state,
              ChordsTestPageModel(
                devices: [midiDevice],
                connectionStatus: ConnectionStatus.connected,
                selectedDevice: midiDevice,
                expectedChord: expectedChord,
                playedNotes: [],
                gameState: const GameState(
                  gamesCount: 0,
                  successCount: 0,
                  currentResult: CurrentResult.none,
                ),
              ),
            );
          },
        );

        test('should disconnect a device when connected', () async {
          final midiDevice = MidiDevice('id', 'name', 'type', false);
          const expectedChord = Chord(name: 'name', notes: []);
          notifier.state = notifier.state.copyWith(
            devices: [midiDevice],
            selectedDevice: midiDevice,
            connectionStatus: ConnectionStatus.connected,
            expectedChord: expectedChord,
            playedNotes: [NotePosition.middleC],
            gameState: GameState.newGame(),
          );

          await notifier.onActionButtonPressed();

          expect(
            notifier.state,
            ChordsTestPageModel(
              devices: [midiDevice],
              connectionStatus: ConnectionStatus.disconnected,
              selectedDevice: midiDevice,
              expectedChord: null,
              playedNotes: [],
              gameState: null,
            ),
          );
        });

        test('should do nothing when a device is not selected', () async {
          final midiDevice = MidiDevice('id', 'name', 'type', false);
          notifier.state = notifier.state.copyWith(
            devices: [midiDevice],
            selectedDevice: null,
            connectionStatus: ConnectionStatus.disconnected,
            expectedChord: null,
            playedNotes: [],
            gameState: null,
          );

          await notifier.onActionButtonPressed();

          expect(
            notifier.state,
            ChordsTestPageModel(
              devices: [midiDevice],
              connectionStatus: ConnectionStatus.disconnected,
              selectedDevice: null,
              expectedChord: null,
              playedNotes: [],
              gameState: null,
            ),
          );
        });
      });
    });
  });
}
