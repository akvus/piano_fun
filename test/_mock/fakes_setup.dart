import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:mocktail/mocktail.dart';

void registerAllCallbacks() {
  registerFallbackValue(MidiDeviceFake());
}

class MidiDeviceFake extends Fake implements MidiDevice {}
