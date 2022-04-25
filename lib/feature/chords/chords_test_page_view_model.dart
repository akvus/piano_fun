import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';

final chordsTestPageViewModelProvder = StateNotifierProvider(
  (ref) => ChordsTestPageViewModel(ref.read(
    midiCommandProvider,
  )),
);

class ChordsTestPageViewModel extends StateNotifier<Object?> {
  ChordsTestPageViewModel(
    this._midiCommand,
  ) : super(null);

  final MidiCommand _midiCommand;
}
