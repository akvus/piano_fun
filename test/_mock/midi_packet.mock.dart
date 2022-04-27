import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:mocktail/mocktail.dart';

class MockedMidiPacket extends Mock implements MidiPacket {
  void mockData(Uint8List expected) {
    when(() => data).thenReturn(expected);
  }
}
