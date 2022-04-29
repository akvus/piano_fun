import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/common/extension/int.dart';
import 'package:fun_with_piano/feature/chords/data/midi_command.dart';
import 'package:fun_with_piano/feature/chords/data/note_mapper.dart';

final midiRepositoryProvider = Provider.autoDispose((ref) => MidiRepository(
      ref.read(midiCommandProvider),
      ref.read(noteMapperProvider),
    ));

const midiPacketStatusIndex = 0;
const midiPacketNoteIndex = 1;

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
          ?.where((event) => !isNoteOnEvent(event.data[midiPacketStatusIndex]))
          .map(
            (event) => _noteMapper.map(event),
          );

  @visibleForTesting
  bool isNoteOnEvent(int data) =>
      data.isBitSet(7) &&
      !data.isBitSet(6) &&
      !data.isBitSet(5) &&
      !data.isBitSet(4);

  Stream<String>? get midiSetupChangeStream => _midiCommand.onMidiSetupChanged;

  Future<List<MidiDevice>> get devices async =>
      await _midiCommand.devices ?? [];

  Future<void> connect(MidiDevice device) =>
      _midiCommand.connectToDevice(device);

  void addVirtualDevice() =>
      _midiCommand.addVirtualDevice(name: 'Virtual device');
}
