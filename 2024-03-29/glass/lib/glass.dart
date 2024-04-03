import 'dart:math';

enum Action { fillFirst, fillSecond, emptyFirst, emptySecond, firstToSecond, secondToFirst }

class State {
  State(
    this.firstBottle,
    this.secondBottle,
    this.firstBottleContents,
    this.secondBottleContents,
    this.actions,
  );

  final int firstBottle;
  final int secondBottle;

  int firstBottleContents = 0;
  int secondBottleContents = 0;

  List<Action> actions = [];

  State performAction(Action action) {
    var actions = this.actions + [action];
    switch (action) {
      case Action.fillFirst:
        return State(firstBottle, secondBottle, firstBottle, secondBottleContents, actions);
      case Action.fillSecond:
        return State(firstBottle, secondBottle, firstBottleContents, secondBottle, actions);
      case Action.emptyFirst:
        return State(firstBottle, secondBottle, 0, secondBottleContents, actions);
      case Action.emptySecond:
        return State(firstBottle, secondBottle, firstBottleContents, 0, actions);
      case Action.firstToSecond:
        var fillAmount = min(firstBottleContents, secondBottle - secondBottleContents);
        return State(
            firstBottle, secondBottle, firstBottleContents - fillAmount, secondBottleContents + fillAmount, actions);
      case Action.secondToFirst:
        var fillAmount = min(secondBottleContents, firstBottle - firstBottleContents);
        return State(
            firstBottle, secondBottle, firstBottleContents + fillAmount, secondBottleContents - fillAmount, actions);
    }
  }

  int get state => firstBottleContents + (firstBottle + 1) * secondBottleContents;
}

class Flasks {
  Flasks(this.firstBottle, this.secondBottle, this.target);
  final int firstBottle;
  final int secondBottle;
  final int target;

  Set<int> visitedStates = {};

  State? findPath(int maxLength) {
    int length = 0;
    Set<int> visitedStates = {0};
    List<State> states = [State(firstBottle, secondBottle, 0, 0, [])];
    while (length < maxLength) {
      List<State> nextStates = [];
      for (final state in states) {
        for (final action in Action.values) {
          final nextState = state.performAction(action);
          final stateValue = nextState.state;
          if (visitedStates.contains(stateValue)) continue;
          if (nextState.firstBottleContents == target || nextState.secondBottleContents == target) return nextState;
          visitedStates.add(stateValue);
          nextStates.add(nextState);
        }
      }
      states = nextStates;
      length++;
    }
    return null;
  }
}
