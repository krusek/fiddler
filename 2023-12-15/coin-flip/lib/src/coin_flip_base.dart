// TODO: Put public facing types in this file.

import 'dart:math';

/// Checks if you are awesome. Spoiler: you are.
class Awesome {
  bool get isAwesome => true;
}

enum Flip { head, tail }

class Target {
  Target(this.target);
  final List<Flip> target;
  List<Flip> _status = [];
  bool addFlip(Flip flip) {
    final status = _status + [flip];
    bool rvalue = false;
    if (_checkTarget(status, target.length)) rvalue = true;
    int length = min(status.length, target.length - 1);
    while (length > 0) {
      if (_checkTarget(status, length)) {
        break;
      }
      length--;
    }
    _status = target.sublist(0, length);
    return rvalue;
  }

  bool _checkTarget(List<Flip> status, int length) {
    if (length > status.length || length > target.length) return false;
    final s = status.sublist(status.length - length);
    final t = target.sublist(0, length);
    for (int i = 0; i < s.length; i++) {
      if (s[i] != t[i]) {
        return false;
      }
    }
    return true;
  }

  int get status => _status.length;
}
