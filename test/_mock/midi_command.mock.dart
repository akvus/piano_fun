import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:mocktail/mocktail.dart';

class MockedMidiCommand extends Mock implements MidiCommand {
  void mockOnMidiDataReceived(Stream<MidiPacket> expected) {
    when(() => onMidiDataReceived).thenAnswer((_) => expected);
  }
}
