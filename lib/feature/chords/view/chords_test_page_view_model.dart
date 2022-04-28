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
          status: ConnectionStatus.noDevices,
          selectedDevice: null,
          expectedChord: null,
          playedNotes: [],
        )) {
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
    )?..onError((e) {
        debugPrint('Error $e');
      });

    final devices = await _midiRepository.devices;

    state = state.copyWith(
      devices: devices,
      status: devices.isNotEmpty
          ? ConnectionStatus.noDevices
          : ConnectionStatus.disconnected,
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

    final status = devices.isEmpty
        ? ConnectionStatus.noDevices
        : ConnectionStatus.disconnected;

    state.copyWith(
      devices: devices,
      status: status,
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
        state.status == ConnectionStatus.connected) {
      status = ConnectionStatus.connected;
    } else {
      status = ConnectionStatus.disconnected;
    }

    state = state.copyWith(
      devices: devices,
      status: status,
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
      switch (state.status) {
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
      status: ConnectionStatus.connected,
      expectedChord: _chordRepository.random,
      playedNotes: [],
    );
  }

  void _stop() {
    state = state.copyWith(
      status: ConnectionStatus.disconnected,
      expectedChord: null,
      playedNotes: [],
    );
  }

  void _onNoteReceived(NotePosition note) {
    if (state.status != ConnectionStatus.connected) {
      debugPrint('Not connected, then why are we getting notes?');
      return;
    }

    debugPrint('Note received: ${note.name}');

    Chord chord = state.expectedChord!;
    List<NotePosition> playedNotes = [note, ...state.playedNotes];

    final chordMatch = _matchChordUseCase(
      chord: chord,
      notes: playedNotes,
    );

    debugPrint('Chord matched with $chordMatch');

    switch (chordMatch) {
      case ChordMatch.matched:
        // TODO success message
        chord = _chordRepository.random;
        playedNotes.clear();
        break;
      case ChordMatch.partial:
        // wait for following notes
        break;
      case ChordMatch.failed:
        // TODO error message
        playedNotes.clear();
        break;
    }

    state = state.copyWith(
      expectedChord: chord,
      playedNotes: playedNotes,
    );
  }

  void onPianoKeyTapped(NotePosition position) => _onNoteReceived(position);
}
