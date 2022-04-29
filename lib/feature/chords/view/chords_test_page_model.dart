import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';
import 'package:piano_chords_test/feature/chords/view/game_state.dart';

part 'chords_test_page_model.freezed.dart';

@freezed
class ChordsTestPageModel with _$ChordsTestPageModel {
  const factory ChordsTestPageModel({
    required List<MidiDevice> devices,
    required ConnectionStatus connectionStatus,
    required MidiDevice? selectedDevice,
    required Chord? expectedChord,
    required List<NotePosition> playedNotes,
    required GameState? gameState,
  }) = _ChordsTestePageModel;
}

enum ConnectionStatus { noDevices, disconnected, connected }
