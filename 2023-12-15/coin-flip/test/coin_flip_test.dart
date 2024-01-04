import 'dart:math';

import 'package:coin_flip/coin_flip.dart';
import 'package:linear_equations/linear_equations.dart';
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

    test('Fiddler', () {
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

    test('set status', () {
      final left = Target([Flip.tail, Flip.tail, Flip.head]);
      for (int ix = 0; ix < 3; ix++) {
        left.setStatus(ix);
        expect(left.status, ix);
      }
    });

    void solve(List<Flip> target_array, List<Flip> target_array2) {
      final target1 = Target(target_array);
      final target2 = Target(target_array2);
      var buffer = StringBuffer('');
      for (int ix = 0; ix <= 2; ix++) {
        for (int iy = 0; iy <= 2; iy++) {
          buffer.write('E($ix,$iy) = ');
          var pieces = <String>[];
          for (Flip flipx in [Flip.head, Flip.tail]) {
            for (Flip flipy in [Flip.head, Flip.tail]) {
              target1.setStatus(ix);
              target2.setStatus(iy);
              var won = target1.addFlip(flipx);
              var lost = target2.addFlip(flipy);
              if (won && !lost) {
                pieces.add('1/4W');
              } else if (!won && lost) {
                pieces.add('1/4L');
              } else {
                pieces.add('1/4E(${target1.status},${target2.status})');
              }
            }
          }
          buffer.writeln(pieces.join('+'));
        }
      }
      String lines = buffer.toString();
      System system = System();
      final parser = Parser('E\\([0-9],[0-9]\\)|W|L');
      for (String line in lines.split('\n')) {
        if (line.isEmpty) continue;
        system.addEquation(parser.parseLine(line));
      }
      var reduced = system.reduce();
      final eq = system.getEquation(reduced, 'E(0,0)');
      print((Fraction.integer(-1) * eq!['W']!).toDouble());
    }

    List<Flip> parseArray(String target) {
      return RegExp('H|T').allMatches(target).map((e) {
        if (e.input.substring(e.start, e.end) == 'T') return Flip.tail;
        return Flip.head;
      }).toList();
    }

    test('Extra Credit', () {
      List<String> targets = ['HHH', 'HHT', 'HTH', 'HTT', 'THH', 'THT', 'TTH', 'TTT'];
      for (final target_string in targets) {
        for (final target_string2 in targets) {
          if (target_string == target_string2) continue;
          final target_array = parseArray(target_string);
          final target_array2 = parseArray(target_string2);
          print('$target_string vs $target_string2');
          solve(target_array, target_array2);
        }
      }
    });
  });
}
