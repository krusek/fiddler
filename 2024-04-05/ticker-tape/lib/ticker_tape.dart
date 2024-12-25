import 'dart:math';

int calculate() {
  return 6 * 7;
}

class State {
  int total = 0;
  int regions = 0;

  @override
  String toString() {
    return 'total: $total, regions $regions, ave: ${total / regions}';
  }
}

class Ticker {
  Map<bool, State> state = {false: State(), true: State()};

  bool top = false;
  bool bottom = false;

  Random rand = Random(0);

  void start() {
    top = rand.nextBool();
    bottom = rand.nextBool();

    state[top]!.total += 1;
    state[bottom]!.total += 1;
    state[top]!.regions = 1;
    state[bottom]!.regions = 1;
  }

  void moveNext() {
    final newTop = rand.nextBool();
    final newBottom = rand.nextBool();
    if (top == bottom) {
      // 1 1 or 0 0
      // 1 1    0 0
      if (newTop == top && newBottom == bottom) {
        state[top]!.total += 2;
      }
      // 1 0 or 1 1
      // 1 1    1 0
      //
      // 0 0 or 0 1
      // 0 1    0 0
      else if (newTop != newBottom) {
        state[top]!.total += 1;
        state[!top]!.total += 1;
        state[!top]!.regions += 1;
      }
      // 1 0 or 0 1
      // 1 0    0 1
      else if (newTop != top && newBottom != bottom) {
        state[!top]!.total != 2;
        state[!top]!.regions += 1;
      } else {
        assert(false);
      }
    } else {
      // 0 1 or 1 1 or 0 0 or 1 0
      // 1 1    0 1    1 0    0 0
      if (newTop == newBottom) {
        state[newTop]!.total += 2;
      }
      // 0 1 or 1 0
      // 1 0    0 1
      else if (newTop != top) {
        state[true]!.regions += 1;
        state[true]!.total += 1;
        state[false]!.regions += 1;
        state[false]!.total += 1;
      }
      // 0 0 or 1 1
      // 1 1    0 0
      else if (top == newTop && bottom == newBottom) {
        state[true]!.total += 1;
        state[false]!.total += 1;
      } else {
        assert(false);
      }
    }
    top = newTop;
    bottom = newBottom;
  }

  @override
  String toString() {
    return 'True ${state[true]!}\nFalse ${state[false]!}';
  }
}
