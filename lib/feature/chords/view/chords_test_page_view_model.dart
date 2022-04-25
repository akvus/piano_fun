import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_model.dart';

// TODO listen to MIDI devices being disconnected etc.

final chordsTestPageViewModelProvder =
    StateNotifierProvider<ChordsTestPageViewModel, ChordsTestPageModel?>(
  (ref) => ChordsTestPageViewModel(
    ref.read(midiCommandProvider),
  ),
);

class ChordsTestPageViewModel extends StateNotifier<ChordsTestPageModel?> {
  ChordsTestPageViewModel(this._midiCommand) : super(null) {
    onInit();
  }

  final MidiCommand _midiCommand;

  Future<void> onInit() async {
    final devices = await _midiCommand.devices;

    final connectionStatus = devices == null || devices.isEmpty
        ? ConnectionStatus.noDevices
        : ConnectionStatus.disconnected;

    state = ChordsTestPageModel(
      devices: devices ?? [],
      status: connectionStatus,
      selectedDevice: null,
    );
  }

  void onDeviceSelected(MidiDevice? device) {
    state = state!.copyWith(selectedDevice: device);
  }
}
