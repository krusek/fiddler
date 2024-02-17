import 'package:test/test.dart';
import 'package:linear_equations/linear_equations.dart';

Fraction evaluate(List<Equation> reduced, String variable, String total) {
  for (Equation equation in reduced) {
    if (equation[variable] == Fraction.one()) return equation[total]?.negate() ?? Fraction.zero();
  }
  return Fraction.zero();
}

void main() {
  test('basic', () {
    System system = System();
    final parser = Parser('E\\([0-9],[0-9]\\)|w|L|d\\_[A-Z]+');
    final text = """
d_C + d_AC = d_B + d_AB
d_AC - d_A = d_B
d_B + d_AB = w
10d_AB+10d_A+10d_AC=10d_AB+20d_B
10d_AC+30d_C = 20d_B+10d_AB
""";
    system.addEquations(parser.parseLines(text));
    print(system.reduce());
  });
  test('basic 2', () {
    System system = System();
    final parser = Parser('E\\([0-9],[0-9]\\)|t[0-9]|w|z|d\\_[A-Z]+');
    final A = "1";
    final B = "1/2";
    final C = "1/3";
    final text = """
${B}t0+${B}t1+${A}t2=z
${A}t0+${C}t1+${C}t2=z
${A}t0=${B}t0+${B}t1+${A}t1
""";
    system.addEquations(parser.parseLines(text));
    final reduced = system.reduce();

    final t0 = evaluate(reduced, 't0', 'z');
    final t1 = evaluate(reduced, 't1', 'z');
    final t2 = evaluate(reduced, 't2', 'z');

    print('t0 = $t0, t1 = $t1, t2 = $t2');
    print('Trip from C\'s point of view');
    print('| --- A = $t0 --- |--- C = ${(t1 + t2) / Fraction.integer(3)} --- |');
    print('Trip from B\'s point of view');
    print('| --- B = ${(t0 + t1) / Fraction.integer(2)} --- | --- A = $t2 --- |');
  });
  test('extra credit', () {
    System system = System();
    final parser = Parser('E\\([0-9],[0-9]\\)|t[0-9]|w|z|d\\_[A-Z]+');
    final A = "1/1";
    final B = "1/2";
    final C = "1/3";
    final D = "1/4";
    final text = """
${B}t0+${B}t1+${B}t2+${B}t3+${A}t4=z
${B}t0+${B}t1+${A}t2+${C}t3+${C}t4=z
${A}t0+${C}t1+${C}t2+${C}t3+${C}t4=z
${A}t0=${B}t0+${B}t1+${A}t1
${C}t4+${C}t3+${A}t3=${A}t4
""";
    system.addEquations(parser.parseLines(text));
    final reduced = system.reduce();

    final t0 = evaluate(reduced, 't0', 'z');
    final t1 = evaluate(reduced, 't1', 'z');
    final t2 = evaluate(reduced, 't2', 'z');
    final t3 = evaluate(reduced, 't3', 'z');
    final t4 = evaluate(reduced, 't4', 'z');
    print('t0 = $t0, t1 = $t1, t2 = $t2, t3 = $t3');
    print('Trip from C\'s point of view');
    print('| --- A = $t0 --- |--- C = ${(t4 + t1 + t2 + t3) / Fraction.integer(3)} --- |');
    print('Trip from D\'s point of view');
    print(
        '| --- B = ${(t0 + t1) / Fraction.integer(2)} --- | --- A = $t2 --- | --- C = ${(t4 + t3) / Fraction.integer(3)} --- |');
    print('Trip from B\'s point of view');
    print('| --- B = ${(t0 + t1 + t2 + t3) / Fraction.integer(2)} --- | --- A = $t4 --- |');
  });
}
