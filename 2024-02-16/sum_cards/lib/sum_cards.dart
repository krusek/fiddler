enum Evaluation { badSequence, goodSequence, shortCircuit }

bool checkLongerSequence(List<int> sequence) {
  int rightSum = 0;
  for (int ix = sequence.length - 1; ix > 0; ix--) {
    rightSum += sequence[ix];
    int leftSum = 0;
    for (int iy = ix - 1; iy >= 0; iy--) {
      leftSum += sequence[iy];
      if (leftSum == rightSum) return false;
      if (leftSum > rightSum) break;
      if (iy == 0) return true;
    }
  }
  return true;
}

List<int> extendSequence(List<int> current, Set<int> middleBad, Set<int> terminalBad, int max, List<int> longest) {
  // print('current: $current, mbad: $middleBad, tbad: $terminalBad');
  // if (current.length == 5) return longest;
  for (int ix = 1; ix <= max; ix++) {
    if (middleBad.contains(ix)) continue;
    if (terminalBad.contains(ix)) continue;

    Set<int> newMiddleBad = {};
    Set<int> newTerminalBad = {};
    for (int b in middleBad) {
      if (b - ix > 0) {
        newMiddleBad.add(b - ix);
      }
    }
    for (int b in terminalBad) {
      if (b - ix > 0) {
        newMiddleBad.add(b - ix);
      }
      newTerminalBad.add(b + ix);
    }
    newTerminalBad.add(ix);
    current.add(ix);
    if (current.length > longest.length) {
      longest = List.from(current);
    }
    longest = extendSequence(current, newMiddleBad, newTerminalBad, max, longest);
    current.removeLast();
  }
  return longest;
}

bool checkSequenceAtIndex(List<int> sequence, int ix) {
  int leftIndex = ix - 1;
  int rightIndex = ix;
  int leftSum = sequence[leftIndex];
  int rightSum = sequence[rightIndex];
  while (leftSum != rightSum) {
    if (leftSum < rightSum) {
      if (leftIndex == 0) return true;
      leftIndex--;
      leftSum += sequence[leftIndex];
    } else if (leftSum > rightSum) {
      if (rightIndex == sequence.length - 1) return true;
      rightIndex++;
      rightSum += sequence[rightIndex];
    }
  }
  return leftSum != rightSum;
}

// Returns true if the sequence is safe.
bool checkSequence(List<int> sequence) {
  for (int ix = sequence.length - 1; ix > 0; ix--) {
    if (!checkSequenceAtIndex(sequence, ix)) return false;
  }
  return true;
}

List<int> findLongest(List<int> current, int maxInteger, List<int> currentLongest, int lastPrint) {
  for (int ix = 1; ix <= maxInteger; ix++) {
    current.add(ix);
    if (checkLongerSequence(current)) {
      if (current.length > currentLongest.length) {
        currentLongest = List.from(current);
        if (currentLongest.length == lastPrint) {
          print(currentLongest);
          lastPrint += 10;
        }
      }
      currentLongest = findLongest(current, maxInteger, currentLongest, lastPrint);
      if (currentLongest.length > lastPrint) {
        lastPrint = currentLongest.length - (currentLongest.length % 10) + 10;
      }
    }
    current.removeLast();
  }
  return currentLongest;
}

void printLongest2(int max) {
  List<int> sequence = [];
  List<int> longest = extendSequence(sequence, {}, {}, max, []);
  print('$max (${longest.length}): $longest');
}

void printLongest(int max) {
  List<int> sequence = [];
  List<int> longest = findLongest(sequence, max, [], 10);
  print('$max (${longest.length}): $longest');
}
