enum Comparison { smaller, bigger, equal, unknown }

class Fraction {
  Fraction(this.numerator, [this.denominator = 1]);
  final int numerator;
  final int denominator;

  Fraction.one()
      : numerator = 1,
        denominator = 1;
  Fraction.zero()
      : numerator = 0,
        denominator = 1;
  Fraction.integer(this.numerator) : denominator = 1;

  static int abs(int a) {
    if (a < 0) return -a;
    return a;
  }

  factory Fraction.reduce(int numerator, int denominator) {
    if (numerator == 0) return Fraction.zero();
    if (denominator < 0) return Fraction.reduce(-numerator, -denominator);
    final gcd = Fraction.gcd(abs(numerator), abs(denominator));
    return Fraction(numerator ~/ gcd, denominator ~/ gcd);
  }

  static int gcd(int a, int b) {
    if (a == 0) return b;
    if (b == 0) return a;

    if (a < b) return gcd(a, b % a);
    if (b < a) return gcd(b, a % b);
    return a;
  }

  Fraction negate() {
    return Fraction(-numerator, denominator);
  }

  Fraction operator +(Fraction f) {
    return Fraction.reduce(f.numerator * denominator + f.denominator * numerator, f.denominator * denominator);
  }

  Fraction operator -(Fraction f) {
    return Fraction.reduce(-f.numerator * denominator + f.denominator * numerator, f.denominator * denominator);
  }

  Fraction operator *(Fraction f) {
    return Fraction.reduce(f.numerator * numerator, f.denominator * denominator);
  }

  Fraction operator /(Fraction f) {
    assert(f.numerator != 0);
    return Fraction.reduce(f.denominator * numerator, f.numerator * denominator);
  }

  @override
  bool operator ==(Object f) {
    if (f is Fraction) {
      return f.numerator == numerator && f.denominator == denominator;
    }
    if (f is int) {
      return f == numerator && denominator == 1;
    }
    if (f is num) {
      return f == numerator && denominator == 1;
    }
    return false;
  }

  @override
  int get hashCode {
    return 7 * numerator.toInt() + denominator.toInt();
  }

  @override
  String toString() {
    if (denominator == 1) return numerator.toString();
    return "$numerator/$denominator";
  }

  Comparison compareTo(Object unit) {
    if (unit is Fraction) {
      final lhs = numerator * unit.denominator;
      final rhs = denominator * unit.numerator;
      if (lhs < rhs) return Comparison.smaller;
      if (lhs > rhs) return Comparison.bigger;
      return Comparison.equal;
    }
    return Comparison.unknown;
  }
}
