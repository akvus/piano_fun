import 'dart:math';

import 'package:mocktail/mocktail.dart';

class MockedRandom extends Mock implements Random {
  void mockNextInt(int expected) {
    when(() => nextInt(any())).thenReturn(expected);
  }
}
