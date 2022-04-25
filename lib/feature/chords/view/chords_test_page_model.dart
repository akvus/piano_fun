import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chords_test_page_model.freezed.dart';

@freezed
class ChordsTestPageModel with _$ChordsTestPageModel {
  const factory ChordsTestPageModel({
    required List<MidiDevice> devices,
    required ConnectionStatus status,
    required MidiDevice? selectedDevice,
  }) = _ChordsTestePageModel;
}

enum ConnectionStatus { noDevices, disconnected, connected }
