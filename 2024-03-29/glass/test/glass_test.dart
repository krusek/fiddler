import 'package:glass/glass.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    final flasks = Flasks(10, 3, 5);
    final state = flasks.findPath(30);
    assert(state != null);
    print(state!.actions);
  });
}
