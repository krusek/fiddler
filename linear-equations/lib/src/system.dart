import 'fraction.dart';

typedef Equation = Map<String, Fraction>;

class System {
  Set<String> variables = {};
  List<Equation> equations = [];

  void addEquations(Iterable<Equation> equations) {
    for (final equation in equations) {
      addEquation(equation);
    }
  }

  void addEquation(Map<String, Fraction> equation) {
    equations.add(equation);
    for (final String variable in equation.keys) {
      variables.add(variable);
    }
  }

  List<List<Fraction>> toMatrix() {
    List<List<Fraction>> matrix = List.empty(growable: true);
    List<String> variables = this.variables.toList()..sort();
    for (int iy = 0; iy < equations.length; iy++) {
      final equation = equations[iy];
      var eq = List.filled(variables.length, Fraction.zero());
      for (int ix = 0; ix < variables.length; ix++) {
        eq[ix] = equation[variables[ix]] ?? Fraction.zero();
      }
      matrix.add(eq);
    }
    return matrix;
  }

  void swap(List<Equation> equations, int ix, int iy) {
    if (ix == iy) return;
    final temp = equations[ix];
    equations[ix] = equations[iy];
    equations[iy] = temp;
  }

  void multiply(Equation equation, Fraction f) {
    for (final key in equation.keys) {
      equation[key] = (equation[key] ?? Fraction.zero()) * f;
    }
  }

  void add(Equation a, Equation b, Fraction f) {
    for (final key in b.keys) {
      a[key] = (a[key] ?? Fraction.zero()) + f * (b[key] ?? Fraction.zero());
    }
  }

  int? findEquation(List<Equation> equations, String variable, int start) {
    for (int ix = start; ix < equations.length; ix++) {
      final equation = equations[ix];
      final coeff = equation[variable];
      if (coeff == null) continue;
      if (coeff.numerator == 0) continue;
      return ix;
    }
    return null;
  }

  List<Equation> reduce() {
    List<String> variables = this.variables.toList()..sort();
    List<Equation> reduced = equations.map((e) => Equation.from(e)).toList();
    int used = 0;
    for (int ix = 0; ix < variables.length && used < variables.length; ix++) {
      final variable = variables[ix];
      var index = findEquation(reduced, variable, used);
      if (index == null) continue;
      swap(reduced, index, used);
      var eq = reduced[used];
      final coeff = eq[variable]!;
      multiply(eq, Fraction.one() / coeff);
      for (int iy = 0; iy < reduced.length; iy++) {
        if (iy == used) continue;
        final eq2 = reduced[iy];
        final coeff2 = eq2[variable];
        if (coeff2 == null || coeff2.numerator == 0) continue;
        add(eq2, eq, coeff2.negate());
      }
      used++;
    }
    return reduced;
  }

  Equation? getEquation(List<Equation> reduced, String variable) {
    for (Equation eq in reduced) {
      if (eq[variable] == Fraction.one()) {
        return eq;
      }
    }
    return null;
  }

  void printReduced(List<Equation> reduced) {
    for (final eq in reduced) {
      for (final key in eq.keys.toList()) {
        if (eq[key]?.numerator == 0) eq.remove(key);
      }
      final keys = eq.keys;
      if (keys.isEmpty) continue;
      var primary = keys.first;
      for (final key in keys) {
        if (eq[key] == Fraction.one()) primary = key;
      }
      StringBuffer buffer = StringBuffer('$primary = ');
      var count = 0;
      for (final key in keys) {
        if (key == primary) continue;
        final value = Fraction.integer(-1) * eq[key]!;
        if (count > 0) {
          buffer.write(' + $value$key');
        } else {
          buffer.write('$value$key');
        }
        count++;
      }
      print(buffer.toString());
    }
  }

  Fraction evaluate(String variable, String total) {
    for (Equation equation in equations) {
      if (equation[variable] == Fraction.one()) return equation[total]?.negate() ?? Fraction.zero();
    }
    return Fraction.zero();
  }

  @override
  String toString() {
    List<String> variables = this.variables.toList()..sort();
    final matrix = toMatrix();
    print(variables);
    for (final eq in matrix) {
      print(eq);
    }
    return '';
  }
}
