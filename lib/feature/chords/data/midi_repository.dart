import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/common/extension/int.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';
import 'package:piano_chords_test/feature/chords/data/note_mapper.dart';

final midiRepositoryProvider = Provider.autoDispose((ref) => MidiRepository(
      ref.read(midiCommandProvider),
      ref.read(noteMapperProvider),
    ));

const statusPositionAtMidiData = 0;
const noteCodePositionAtMidiData = 1;

class MidiRepository {
  MidiRepository(
    this._midiCommand,
    this._noteMapper,
  );

  final MidiCommand _midiCommand;
  final NoteMapper _noteMapper;
  Stream<NotePosition>? get notesStream =>
      // Note: There are two MIDI events for each key pressed: on, off.
      // Currently we need not to know this, so we can skip the off events
      _midiCommand.onMidiDataReceived
          ?.where(
              (event) => !isNoteOnEvent(event.data[statusPositionAtMidiData]))
          .map(
            (event) => _noteMapper.map(event),
          );

  @visibleForTesting
  bool isNoteOnEvent(int data) {
    return data.checkBit(7) &&
        !data.checkBit(6) &&
        !data.checkBit(5) &&
        !data.checkBit(4);
  }

  Stream<String>? get midiSetupChangeStream => _midiCommand.onMidiSetupChanged;

  Future<List<MidiDevice>> get devices async {
    final devices = await _midiCommand.devices;

    return devices ?? [];
  }

  Future<void> connect(MidiDevice device) =>
      _midiCommand.connectToDevice(device);
}
