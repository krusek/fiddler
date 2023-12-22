import 'package:linear_equations/linear_equations.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    final parser = Parser('E\\([0-9],[0-9]\\)|W|L');
    parser.parseLine('E(0,0)=-1/24E(0,0)+-1/3E(0,1)+2/5W+E(1,1)+1/4E(1,1)-1/5E(2,2)-E(1,1)');
  });

  test('calculate2', () {
    final parser = Parser('E\\([0-9],[0-9]\\)|W|L');
    final lines = [
      'E(0,0) = 1/4E(1,0) + 1/4E(0,1)+1/4E(1,1)+1/4E(0,0)',
      'E(1,0) = 1/4E(0,0)+1/4E(2,0)+1/4E(0,1)+1/4E(2,1)',
      'E(0,1) = 1/4E(0,0)+1/4E(1,2)+1/4E(1,0)+1/4E(0,2)',
      'E(2,0) = 1/2W+1/4E(2,0)+1/4E(2,1)',
      'E(2,1)=1/2W+1/4E(2,0)+1/4E(2,2)',
      'E(2,2)=1/4W+1/4L+1/4E(0,2)+1/4E(2,0)',
      'E(0,2)=1/2L+1/4E(0,0)+1/4E(1,0)',
      'E(1,2)=1/2L+1/4E(2,0)+1/4E(0,0)',
      'E(1,1)=1/4E(2,2)+1/4E(2,0)+1/4E(0,2)+1/4E(0,0)'
    ];
    System system = System();
    for (final line in lines) {
      system.addEquation(parser.parseLine(line));
    }
    print(system);
    system.reduce();
  });

  test('4 dots', () {
    final parser = Parser('E\\([0-9]\\)|W|L');
    final lines = [
      'E(0) = 1W + E(1)',
      'E(1) = 1W + 1/4E(0)+3/4E(2)',
      'E(2) = 1W + 1/2E(1)+1/2E(3)',
      'E(3) = 1W + 3/4E(2)',
    ];
    System system = System();
    for (final line in lines) {
      system.addEquation(parser.parseLine(line));
    }
    print(system);
    system.reduce();
  });
}
