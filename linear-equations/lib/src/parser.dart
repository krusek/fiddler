import 'fraction.dart';

class Matchers {
  Matchers(String variableRegex) : variable = RegExp(variableRegex);
  final RegExp variable;
  final RegExp operation = RegExp('^\\-|\\+\$');
  final RegExp coefficient = RegExp('^(\\-?[1-9][0-9]*)(\\/([1-9][0-9]+))?\$');
  final RegExp number = RegExp('^[1-9][0-9]*\$');
  final RegExp divide = RegExp('^\\/\$');
}

class Monomial {
  Monomial(this.coefficient, this.variable);
  final Fraction coefficient;
  final String variable;

  @override
  String toString() {
    return '$coefficient * $variable';
  }
}

enum TokenType { number, operator, divide, variable, empty, unknown }

class Token {
  Token(this.token, this.type);
  final String token;
  final TokenType type;

  static Token fromString(String token, Matchers matchers) {
    token = token.trim();
    if (token.isEmpty) return Token(token, TokenType.empty);
    if (matchers.variable.hasMatch(token)) {
      return Token(token, TokenType.variable);
    }
    if (matchers.number.hasMatch(token)) {
      return Token(token, TokenType.number);
    }
    if (matchers.divide.hasMatch(token)) {
      return Token(token, TokenType.divide);
    }
    if (matchers.operation.hasMatch(token)) {
      return Token(token, TokenType.operator);
    }
    return Token(token, TokenType.unknown);
  }

  @override
  String toString() {
    return '$type - $token';
  }
}

class Tokenizer {
  Tokenizer(this.matchers);
  final Matchers matchers;

  List<Token> tokens = [];
  int index = 0;

  void tokenize(final String line) {
    String current = line.trim();
    print(current);
    current = current
        .replaceAll('+\\s*+', '+')
        .replaceAll('+', ' + ')
        .replaceAll('-', ' - ')
        .replaceAll('=', ' = ')
        .replaceAll('/', ' / ')
        .replaceAllMapped(matchers.variable, (match) => ' ${match.input.substring(match.start, match.end)} ');
    print(current);
    final pieces = current.split(' ').where((element) => element.trim().isNotEmpty).toList();
    tokens =
        pieces.map((e) => Token.fromString(e, matchers)).where((element) => element.type != TokenType.empty).toList();
  }

  Token get token => tokens[index];

  bool nextToken() {
    if (index >= tokens.length - 1) return false;
    index++;
    return true;
  }

  @override
  String toString() {
    return tokens.toString();
  }

  void assertToken(final TokenType type) {
    assert(token.type == type, 'Expected token of type: $type but found ${token.type} at $index from $tokens');
  }
}

class Parser {
  Parser(String variable) : matchers = Matchers(variable);
  final Matchers matchers;
  Map<String, Fraction> parseLine(String line) {
    final parts = line.split('=');
    assert(parts.length == 2);
    Tokenizer tokenizer = Tokenizer(matchers);
    tokenizer.tokenize(parts[0]);
    final lhs = _evaluateSide(tokenizer);
    print(lhs);
    tokenizer.tokenize(parts[1]);
    final rhs = _evaluateSide(tokenizer);
    print(rhs);
    for (final String key in rhs.keys) {
      lhs[key] = (lhs[key] ?? Fraction.zero()) - (rhs[key] ?? Fraction.zero());
    }
    print(lhs);
    return lhs;
  }

  Map<String, Fraction> _evaluateSide(Tokenizer tokenizer) {
    final monomial = _getMonomial(tokenizer, false);
    Map<String, Fraction> map = {};
    map[monomial.variable] = monomial.coefficient;
    while (tokenizer.nextToken()) {
      tokenizer.assertToken(TokenType.operator);
      bool negate = tokenizer.token.token == '-';
      tokenizer.nextToken();
      final monomial = _getMonomial(tokenizer, negate);
      map[monomial.variable] = (map[monomial.variable] ?? Fraction.zero()) + monomial.coefficient;
    }
    return map;
  }

  Monomial _getMonomial(Tokenizer tokenizer, bool negate) {
    Fraction coefficient = _getCoefficient(tokenizer, negate);
    tokenizer.assertToken(TokenType.variable);
    String variable = tokenizer.token.token;
    return Monomial(coefficient, variable);
  }

  Fraction _getCoefficient(Tokenizer tokenizer, bool negate) {
    // Coefficient is one of:
    // - n / n
    // - n
    // -
    // n / n
    // n
    // ''
    Fraction value = Fraction.one();
    if (tokenizer.token.token == '-') {
      negate = !negate;
      tokenizer.nextToken();
    }
    value = negate ? value.negate() : value;
    if (tokenizer.token.type == TokenType.number) {
      value = value * Fraction.integer(int.parse(tokenizer.token.token));
      tokenizer.nextToken();
      if (tokenizer.token.type == TokenType.divide) {
        tokenizer.nextToken();
        tokenizer.assertToken(TokenType.number);
        value = value / Fraction.integer(int.parse(tokenizer.token.token));
        tokenizer.nextToken();
      }
    }
    return value;
  }
}
