import 'dart:async';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/chord_repository.dart';
import 'package:piano_chords_test/feature/chords/data/midi_repository.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/domain/match_chord_use_case.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_model.dart';

enum MidiSetUpChangeEvent { deviceFound, deviceLost }

final chordsTestPageViewModelProvder =
    StateNotifierProvider<ChordsTestPageViewModel, ChordsTestPageModel?>(
  (ref) => ChordsTestPageViewModel(
    ref.read(midiRepositoryProvider),
    ref.read(chordRepositoryProvider),
    ref.read(matchChordUseCaseProvider),
  ),
);

// TODO can the model be non-nullable?
// TODO too late for TDD, but maybe test some :D
class ChordsTestPageViewModel extends StateNotifier<ChordsTestPageModel?> {
  ChordsTestPageViewModel(
    this._midiRepository,
    this._chordRepository,
    this._matchChordUseCase,
  ) : super(null) {
    onInit();
  }

  final MidiRepository _midiRepository;
  final ChordRepository _chordRepository;
  final MatchChordUseCase _matchChordUseCase;

  late final StreamSubscription? _midiSetupChangeSub;
  late final StreamSubscription? _midiDataReceiverSub;

  Future<void> onInit() async {
    await _resetState();

    _midiSetupChangeSub =
        _midiRepository.midiSetupChangeStream?.listen((event) {
      if (event == MidiSetUpChangeEvent.deviceFound.name ||
          event == MidiSetUpChangeEvent.deviceLost.name) {
        _onDevicesUpdated();
      }
    });

    _midiDataReceiverSub = _midiRepository.notesStream?.listen(
      (note) => _onNoteReceived(note),
    );
  }

  @override
  void dispose() {
    _midiSetupChangeSub?.cancel();
    _midiDataReceiverSub?.cancel();
    super.dispose();
  }

  Future<void> _resetState() async {
    final devices = await _midiRepository.devices;

    final connectionStatus = devices.isEmpty
        ? ConnectionStatus.noDevices
        : ConnectionStatus.disconnected;

    state = ChordsTestPageModel(
      devices: devices,
      status: connectionStatus,
      selectedDevice: null,
      expectedChord: null,
      playedNotes: [],
    );
  }

  Future<void> _onDevicesUpdated() async {
    final currentState = state!;

    final devices = await _midiRepository.devices;
    ConnectionStatus status;
    MidiDevice? selectedDevice;

    try {
      selectedDevice = devices.firstWhere(
          (element) => element.name == currentState.selectedDevice!.name);
    } catch (e) {
      selectedDevice == null;
    }

    if (devices.isEmpty) {
      status = ConnectionStatus.noDevices;
    } else if (selectedDevice != null &&
        currentState.status == ConnectionStatus.connected) {
      status = ConnectionStatus.connected;
    } else {
      status = ConnectionStatus.disconnected;
    }

    state = currentState.copyWith(
      devices: devices,
      status: status,
      selectedDevice: selectedDevice,
    );
  }

  void onDeviceSelected(MidiDevice? device) {
    state = state!.copyWith(selectedDevice: device);
  }

  void onActionButtonPressed() {
    final currentState = state!;

    if (currentState.selectedDevice == null) {
      // TODO display error - maybe as the next status 'deviceNotSelected'
    } else {
      final status = currentState.status == ConnectionStatus.connected
          ? ConnectionStatus.disconnected
          : ConnectionStatus.connected;
      final chord = _chordRepository.random;

      state = currentState.copyWith(
        status: status,
        expectedChord: chord,
        playedNotes: [],
      );
    }
  }

  void _onNoteReceived(Note note) {
    final currentState = state!;

    if (currentState.status != ConnectionStatus.connected) {
      return;
    }

    Chord chord = currentState.expectedChord!;
    List<Note> playedNotes = [note, ...currentState.playedNotes];

    final chordMatch = _matchChordUseCase(
        chord: currentState.expectedChord!, notes: playedNotes);

    switch (chordMatch) {
      case ChordMatch.matched:
        // TODO success message
        chord = _chordRepository.random;
        playedNotes = [];
        break;
      case ChordMatch.partial:
        // wait for following notes
        break;
      case ChordMatch.failed:
        // TODO error message
        playedNotes = [];
        break;
    }

    state = currentState.copyWith(expectedChord: chord, playedNotes: []);
  }
}
