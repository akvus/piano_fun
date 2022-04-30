import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/data/chord_repository.dart';
import 'package:fun_with_piano/feature/chords/data/midi_repository.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';
import 'package:fun_with_piano/feature/chords/domain/match_chord_use_case.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_model.dart';
import 'package:fun_with_piano/feature/chords/view/game_state.dart';
import 'package:time/time.dart';

enum MidiSetUpChangeEvent { deviceFound, deviceLost }

final chordsTestPageViewModelProvder =
    StateNotifierProvider<ChordsTestPageViewModel, ChordsTestPageModel>(
  (ref) => ChordsTestPageViewModel(
    ref.read(midiRepositoryProvider),
    ref.read(chordRepositoryProvider),
    ref.read(matchChordUseCaseProvider),
  ),
);

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
    _listenToMidiCommands();
    await _initDevices();
  }

  @override
  void dispose() {
    _midiSetupChangeSub?.cancel();
    _midiDataReceiverSub?.cancel();
    super.dispose();
  }

  void _listenToMidiCommands() {
    _midiSetupChangeSub =
        _midiRepository.midiSetupChangeStream?.listen((event) {
      if (event == MidiSetUpChangeEvent.deviceFound.name ||
          event == MidiSetUpChangeEvent.deviceLost.name) {
        onDevicesUpdated();
      }
    });

    _midiDataReceiverSub = _midiRepository.notesStream?.listen(
      (note) => onNoteReceived(note),
    )?..onError((e) => debugPrint('Error: $e'));
  }

  @visibleForTesting
  Future<void> onDevicesUpdated() async {
    final devices = await _midiRepository.devices;
    ConnectionStatus connectionStatus;
    MidiDevice? selectedDevice;

    try {
      selectedDevice = devices.firstWhere(
        (device) => device.name == state.selectedDevice!.name,
      );
    } catch (e) {
      selectedDevice == null;
    }

    if (devices.isEmpty) {
      connectionStatus = ConnectionStatus.noDevices;
    } else if (selectedDevice != null &&
        state.connectionStatus == ConnectionStatus.connected) {
      connectionStatus = ConnectionStatus.connected;
    } else {
      connectionStatus = ConnectionStatus.disconnected;
    }

    state = state.copyWith(
      devices: devices,
      connectionStatus: connectionStatus,
      selectedDevice: selectedDevice,
    );
  }

  Future<void> onNoteReceived(NotePosition note) async {
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
    Future delay() => Future.delayed(200.milliseconds);

    switch (chordMatch) {
      case ChordMatch.matched:
        state = state.copyWith(playedNotes: playedNotes);
        await delay();

        chord = _chordRepository.random;
        playedNotes.clear();
        gameState = gameState.addSuccess();
        break;
      case ChordMatch.partial:
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

  void onDeviceSelected(MidiDevice? device) {
    state = state.copyWith(selectedDevice: device);
  }

  Future<void> onActionButtonPressed() async {
    if (state.selectedDevice != null) {
      switch (state.connectionStatus) {
        case ConnectionStatus.loading:
        case ConnectionStatus.noDevices:
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
    state = state.copyWith(connectionStatus: ConnectionStatus.loading);

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
}
