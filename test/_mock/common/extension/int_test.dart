import 'package:flutter_test/flutter_test.dart';
import 'package:fun_with_piano/common/extension/int.dart';

void main() {
  group('IntExtension', () {
    group('isBitSet', () {
      test('should check bits for 2', () {
        expect(2.isBitSet(0), false);
        expect(2.isBitSet(1), true);
      });

      test('should check bits for 128', () {
        expect(128.isBitSet(0), false);
        expect(128.isBitSet(1), false);
        expect(128.isBitSet(2), false);
        expect(128.isBitSet(3), false);
        expect(128.isBitSet(4), false);
        expect(128.isBitSet(5), false);
        expect(128.isBitSet(6), false);
        expect(128.isBitSet(7), true);
      });

      test('should check bits for 128', () {
        expect(144.isBitSet(0), false);
        expect(144.isBitSet(1), false);
        expect(144.isBitSet(2), false);
        expect(144.isBitSet(3), false);
        expect(144.isBitSet(4), true);
        expect(144.isBitSet(5), false);
        expect(144.isBitSet(6), false);
        expect(144.isBitSet(7), true);
      });
    });
  });
}
