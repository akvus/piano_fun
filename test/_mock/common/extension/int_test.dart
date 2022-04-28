import 'package:flutter_test/flutter_test.dart';
import 'package:piano_chords_test/common/extension/int.dart';

void main() {
  group('IntExtension', () {
    group('checkBit', () {
      test('should check bits for 2', () {
        expect(2.checkBit(0), false);
        expect(2.checkBit(1), true);
      });

      test('should check bits for 128', () {
        expect(128.checkBit(0), false);
        expect(128.checkBit(1), false);
        expect(128.checkBit(2), false);
        expect(128.checkBit(3), false);
        expect(128.checkBit(4), false);
        expect(128.checkBit(5), false);
        expect(128.checkBit(6), false);
        expect(128.checkBit(7), true);
      });

      test('should check bits for 128', () {
        expect(144.checkBit(0), false);
        expect(144.checkBit(1), false);
        expect(144.checkBit(2), false);
        expect(144.checkBit(3), false);
        expect(144.checkBit(4), true);
        expect(144.checkBit(5), false);
        expect(144.checkBit(6), false);
        expect(144.checkBit(7), true);
      });
    });
  });
}
