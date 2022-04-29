import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fun_with_piano/feature/chords/data/chord_repository.dart';

import '../../../_mock/random.mock.dart';

void main() {
  group('$ChordRepository', () {
    late MockedRandom mockedRandom;
    late ChordRepository repository;

    setUp(() {
      mockedRandom = MockedRandom();
      repository = ChordRepository(mockedRandom);
    });

    group('random', () {
      test('should randomize within all of the items', () {
        mockedRandom.mockNextInt(repository.all.length - 1);

        repository.random;

        verify(() => mockedRandom.nextInt(repository.all.length)).called(1);
      });
    });
  });
}
