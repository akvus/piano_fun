import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/data/midi_command.dart';
import 'package:piano_chords_test/feature/chords/data/note_mapper.dart';
import 'package:piano_chords_test/feature/chords/domain/note.dart';

final midiRepositoryProvider = Provider.autoDispose((ref) => MidiRepository(
      ref.read(midiCommandProvider),
      ref.read(noteMapperProvider),
    ));

class MidiRepository {
  MidiRepository(
    this._midiCommand,
    this._noteMapper,
  );

  final MidiCommand _midiCommand;
  final NoteMapper _noteMapper;

  Stream<Note>? get notesStream => _midiCommand.onMidiDataReceived?.map(
        (event) => _noteMapper.map(event),
      );

  Stream<String>? get midiSetupChangeStream => _midiCommand.onMidiSetupChanged;

  Future<List<MidiDevice>> get devices async {
    final devices = await _midiCommand.devices;

    return devices ?? [];
  }
}
