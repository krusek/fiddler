import 'package:super_bowl/super_bowl.dart';
import 'package:test/test.dart';
import 'package:linear_equations/linear_equations.dart';

void main() {
  test('fiddler', () {
    System system = System();
    final parser = Parser('H\\([0-9]\\)|A\\(0\\)|W|L|A');
    final text = """
A=1/3H(3)+1/3H(7)+1/3H(0)
H(3)=1/3A(0)+1/3L+1/3W
H(7)=1/3W+1/3A(0)+1/3W
H(0)=1/3L+1/3L+1/3A(0)
A(0)=1/3H(0)+1/3W+1/3W
""";
    system.addEquations(parser.parseLines(text));

    final reduced = system.reduce();

    final w = evaluate(reduced, 'A', 'W');
    final l = evaluate(reduced, 'A', 'L');

    print('win: $w, loss: $l');
  });
  test('extra credit', () {
    System system = System();
    final parser = Parser('H\\([0-9]\\)|A\\(0\\)|W|L|A');
    final text = """
A=1/3H(3)+1/3H(7)+1/3H(0)
H(3)=1/2W+1/2L
H(7)=1/2A(0)+1/2L
H(0)=1/3L+1/3L+1/3A(0)
A(0)=1/3H(0)+1/3W+1/3W
""";
    system.addEquations(parser.parseLines(text));
    print(system.reduce());
    final reduced = system.reduce();

    final w = evaluate(reduced, 'A', 'W');
    final l = evaluate(reduced, 'A', 'L');

    print('win: $w, loss: $l');
  });
}
