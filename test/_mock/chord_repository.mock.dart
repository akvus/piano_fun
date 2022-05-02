import 'package:fun_with_piano/feature/chords/data/chord_repository.dart';
import 'package:fun_with_piano/feature/chords/domain/chord.dart';
import 'package:mocktail/mocktail.dart';

class MockedChordRepository extends Mock implements ChordRepository {
  void mockRnadom(Chord expected) {
    when(() => random).thenReturn(expected);
  }
}
