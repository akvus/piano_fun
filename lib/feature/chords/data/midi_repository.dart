import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';
import 'package:piano_chords_test/feature/chords/data/note_mapper.dart';

final midiRepositoryProvider = Provider.autoDispose((ref) => MidiRepository(
      ref.read(midiCommandProvider),
      ref.read(noteMapperProvider),
    ));

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
      // TODO test
      _midiCommand.onMidiDataReceived
          ?.distinct((prev, current) =>
              prev.data[noteCodePositionAtMidiData] ==
              current.data[noteCodePositionAtMidiData])
          .map(
            (event) => _noteMapper.map(event),
          );

  Stream<String>? get midiSetupChangeStream => _midiCommand.onMidiSetupChanged;

  Future<List<MidiDevice>> get devices async {
    final devices = await _midiCommand.devices;

    return devices ?? [];
  }

  Future<void> connect(MidiDevice device) =>
      _midiCommand.connectToDevice(device);
}
