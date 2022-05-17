import 'package:flutter_midi/flutter_midi.dart';
import 'package:mocktail/mocktail.dart';

class MockedFlutterMidi extends Mock implements FlutterMidi {
  void mockPrepare() {
    when(() => prepare(sf2: any(named: 'sf2'), name: any(named: 'name')))
        .thenAnswer((invocation) => Future.value());
  }
}
