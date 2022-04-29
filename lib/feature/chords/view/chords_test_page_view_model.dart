import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/data/chord_repository.dart';
import 'package:piano_chords_test/feature/chords/data/midi_repository.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/domain/match_chord_use_case.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_model.dart';
import 'package:piano_chords_test/feature/chords/view/game_state.dart';

enum MidiSetUpChangeEvent { deviceFound, deviceLost }

final chordsTestPageViewModelProvder =
    StateNotifierProvider<ChordsTestPageViewModel, ChordsTestPageModel>(
  (ref) => ChordsTestPageViewModel(
    ref.read(midiRepositoryProvider),
    ref.read(chordRepositoryProvider),
    ref.read(matchChordUseCaseProvider),
  ),
);

// TODO too late for TDD, but maybe test some :D
class ChordsTestPageViewModel extends StateNotifier<ChordsTestPageModel> {
  ChordsTestPageViewModel(
    this._midiRepository,
    this._chordRepository,
    this._matchChordUseCase,
  ) : super(const ChordsTestPageModel(
          devices: [],
          connectionStatus: ConnectionStatus.noDevices,
          selectedDevice: null,
          expectedChord: null,
          playedNotes: [],
          gameState: null,
        )) {
    onInit();
  }

  final MidiRepository _midiRepository;
  final ChordRepository _chordRepository;
  final MatchChordUseCase _matchChordUseCase;

  late final StreamSubscription? _midiSetupChangeSub;
  late final StreamSubscription? _midiDataReceiverSub;

  Future<void> onInit() async {
    _midiSetupChangeSub =
        _midiRepository.midiSetupChangeStream?.listen((event) {
      if (event == MidiSetUpChangeEvent.deviceFound.name ||
          event == MidiSetUpChangeEvent.deviceLost.name) {
        _onDevicesUpdated();
      }
    });

    _midiDataReceiverSub = _midiRepository.notesStream?.listen(
      (note) => _onNoteReceived(note),
    )?..onError((e) {
        debugPrint('Error $e');
      });

    await _initDevices();
  }

  @override
  void dispose() {
    _midiSetupChangeSub?.cancel();
    _midiDataReceiverSub?.cancel();
    super.dispose();
  }

  Future<void> _initDevices() async {
    _midiRepository.addVirtualDevice();
    final devices = await _midiRepository.devices;

    final status = devices.isEmpty
        ? ConnectionStatus.noDevices
        : ConnectionStatus.disconnected;

    state = state.copyWith(
      devices: devices,
      connectionStatus: status,
    );
  }

  Future<void> _onDevicesUpdated() async {
    final devices = await _midiRepository.devices;
    ConnectionStatus status;
    MidiDevice? selectedDevice;

    try {
      selectedDevice = devices.firstWhere(
        (element) => element.name == state.selectedDevice!.name,
      );
    } catch (e) {
      selectedDevice == null;
    }

    if (devices.isEmpty) {
      status = ConnectionStatus.noDevices;
    } else if (selectedDevice != null &&
        state.connectionStatus == ConnectionStatus.connected) {
      status = ConnectionStatus.connected;
    } else {
      status = ConnectionStatus.disconnected;
    }

    state = state.copyWith(
      devices: devices,
      connectionStatus: status,
      selectedDevice: selectedDevice,
    );
  }

  void onDeviceSelected(MidiDevice? device) {
    state = state.copyWith(selectedDevice: device);
  }

  Future<void> onActionButtonPressed() async {
    if (state.selectedDevice == null) {
      // TODO display info to select a device
    } else {
      switch (state.connectionStatus) {
        case ConnectionStatus.noDevices:
          // TODO: display some message relevant
          break;
        case ConnectionStatus.disconnected:
          await _start();
          break;
        case ConnectionStatus.connected:
          _stop();
          break;
      }
    }
  }

  Future<void> _start() async {
    assert(state.selectedDevice != null);

    await _midiRepository.connect(state.selectedDevice!);

    state = state.copyWith(
      connectionStatus: ConnectionStatus.connected,
      expectedChord: _chordRepository.random,
      playedNotes: [],
      gameState: GameState.newGame(),
    );
  }

  void _stop() {
    state = state.copyWith(
      connectionStatus: ConnectionStatus.disconnected,
      expectedChord: null,
      playedNotes: [],
      gameState: null,
    );
  }

  Future<void> _onNoteReceived(NotePosition note) async {
    if (state.connectionStatus != ConnectionStatus.connected) {
      debugPrint('Not connected, then why are we getting notes?');
      return;
    }

    debugPrint('Note received: ${note.name}');

    Chord chord = state.expectedChord!;
    List<NotePosition> playedNotes = [note, ...state.playedNotes];
    GameState gameState = state.gameState!;

    final chordMatch = _matchChordUseCase(
      chord: chord,
      notes: playedNotes,
    );

    debugPrint('Chord matched with $chordMatch');

    // Delay used to display all of the played notes for a while
    // before piano is cleared
    // ignore: prefer_function_declarations_over_variables
    final Future Function() delay =
        () => Future.delayed(const Duration(milliseconds: 200));

    switch (chordMatch) {
      case ChordMatch.matched:
        state = state.copyWith(playedNotes: playedNotes);
        await delay();

        chord = _chordRepository.random;
        playedNotes.clear();
        gameState = gameState.addSuccess();
        break;
      case ChordMatch.partial:
        // wait for following notes
        break;
      case ChordMatch.failed:
        state = state.copyWith(playedNotes: playedNotes);
        await delay();

        playedNotes.clear();
        gameState = gameState.addFailure();
        break;
    }

    state = state.copyWith(
      expectedChord: chord,
      playedNotes: playedNotes,
      gameState: gameState,
    );
  }

  void onPianoKeyTapped(NotePosition position) => _onNoteReceived(position);
}
