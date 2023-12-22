import 'dart:math';

import 'package:coin_flip/coin_flip.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      final target = Target([Flip.head, Flip.head, Flip.tail]);
      expect(target.addFlip(Flip.head), false);
      expect(target.status, 1);
      expect(target.addFlip(Flip.head), false);
      expect(target.status, 2);
      expect(target.addFlip(Flip.head), false);
      expect(target.status, 2);
      expect(target.addFlip(Flip.head), false);
      expect(target.status, 2);
      expect(target.addFlip(Flip.tail), true);
      expect(target.status, 0);
    });

    test('Simulation', () {
      int tth = 0;
      int ttt = 0;
      final count = 1000000;
      final random = Random(0);
      for (int ix = 0; ix < count; ix++) {
        final left = Target([Flip.tail, Flip.tail, Flip.head]);
        final right = Target([Flip.tail, Flip.tail, Flip.tail]);
        int won = 0;
        while (won % 2 == 0) {
          won -= left.addFlip(random.nextBool() ? Flip.head : Flip.tail) ? 1 : 0;
          won += right.addFlip(random.nextBool() ? Flip.head : Flip.tail) ? 1 : 0;
        }
        if (won == -1) {
          tth += 1;
        } else if (won == 1) {
          ttt += 1;
        }
      }
      print('tth: $tth, ttt: $ttt');
    });
  });
}
