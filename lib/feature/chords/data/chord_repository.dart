import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/domain/chord.dart';

final chrodRepositoryProvider = Provider.autoDispose(
  (ref) => ChordRepository(),
);

class ChordRepository {
  Chord get random => throw Exception();

  List<Chord> get all => throw Exception();
}
