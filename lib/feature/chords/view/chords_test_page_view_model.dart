import 'dart:async';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_model.dart';

enum MidiSetUpChangeEvent { deviceFound, deviceLost }

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

  late final StreamSubscription? _midiSetupChangeSub;
  late final StreamSubscription? _midiDataReceiverSub;

  Future<void> onInit() async {
    await _resetState();

    _midiSetupChangeSub = _midiCommand.onMidiSetupChanged?.listen((event) {
      if (event == MidiSetUpChangeEvent.deviceFound.name ||
          event == MidiSetUpChangeEvent.deviceLost.name) {
        _onDevicesUpdated();
      }
    });

    _midiDataReceiverSub = _midiCommand.onMidiDataReceived?.listen((data) {
      _onMidiMessageReceived(data);
    });
  }

  @override
  void dispose() {
    _midiSetupChangeSub?.cancel();
    _midiDataReceiverSub?.cancel();
    super.dispose();
  }

  Future<void> _resetState() async {
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

  Future<void> _onDevicesUpdated() async {
    final currentState = state!;

    final devices = await _midiCommand.devices ?? [];
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

  void onStartPressed() {
    final currentState = state!;

    if (currentState.selectedDevice == null) {
      // TODO display error - maybe as the next status 'deviceNotSelected'
    } else {
      final status = currentState.status == ConnectionStatus.connected
          ? ConnectionStatus.disconnected
          : ConnectionStatus.connected;
      state = currentState.copyWith(status: status);
    }
  }

  void _onMidiMessageReceived(MidiPacket data) {
    // TODO handle notes
  }
}
