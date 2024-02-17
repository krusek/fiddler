import 'package:linear_equations/linear_equations.dart';

void main(List<String> arguments) {
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
}
