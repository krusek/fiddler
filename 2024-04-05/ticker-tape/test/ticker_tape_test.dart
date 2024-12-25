import 'package:ticker_tape/ticker_tape.dart';
import 'package:test/test.dart';
import 'package:linear_equations/linear_equations.dart';

void main() {
  test('fiddler', () {
    System system = System();
    final parser = Parser('H\\([0-9]\\)|W|L|A');
    final text = """
A = W + 1/5 W + 1/5 H(2) + 4/5 H(1)
H(1) = 1/4 H(2) + 1/2W + 1/4 H(1) + 1/4W
H(2) = 1/2 H(1) + 1/2W + 1/4 H(2) + 2/4W
""";
    system.addEquations(parser.parseLines(text));

    final reduced = system.reduce();

    final w = evaluate(reduced, 'A', 'W').toDouble();
    // final l = evaluate(reduced, 'A', 'L');
    system.printReduced(reduced);
    print('win: $w');
  });
}
