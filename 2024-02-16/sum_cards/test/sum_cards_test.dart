import 'package:sum_cards/sum_cards.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    print(checkSequence([1, 2, 1]));
    expect(checkSequence([1, 2, 1]), true);
    expect(checkSequence([1, 2, 1, 2]), false);
    expect(checkSequence([3, 1, 3, 2, 3, 1, 3]), true);
    expect(checkSequence([3, 1, 3, 2, 3, 1, 3, 1]), false);
    expect(checkSequence([3, 1, 3, 2, 3, 1, 3, 2]), false);
    expect(checkSequence([3, 1, 3, 2, 3, 1, 3, 3]), false);
    expect(checkSequence([1, 2, 1, 5, 1, 3, 8, 3, 4, 2]), true);
    expect(checkSequence([1, 2, 1, 5, 1, 3, 8, 3, 6, 7, 3, 6, 8, 4, 8, 6, 3, 6, 4, 8]), true);
    expect(checkSequence([1, 2, 1, 5, 2, 5, 8, 6, 5, 3, 5, 7, 8, 5, 1, 7, 3, 6, 7, 8, 6, 5, 3, 5, 6, 1, 8, 6, 8, 3]),
        true);
    expect(checkSequence([1, 2, 1]), true);
    expect(checkSequence([1, 1]), false);
    printLongest(1);
    printLongest2(1);
    printLongest(2);
    printLongest2(2);
    printLongest(3);
    printLongest2(3);
    printLongest(4);
    printLongest2(4);
    printLongest(5);
    printLongest2(5);
    printLongest(6);
    printLongest2(6);
    printLongest(7);
    printLongest2(7);
    printLongest(8);
    printLongest2(8);
  });
}
