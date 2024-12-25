Iterable<List<int>> getSum(int upperBound, int sum) sync* {
  if (upperBound <= 1) return;
  final sq = upperBound * upperBound;
  if (sq == sum) yield [upperBound];
  if (sq < sum) {
    for (final ls in getSum(upperBound, sum - sq)) {
      yield [upperBound] + ls;
    }
  }
  for (final ls in getSum(upperBound - 2, sum)) {
    yield ls;
  }
}

Iterable<List<int>> getSquares(int side) {
  if (side % 2 == 0) {
    return getSum(side - 1, side * side);
  }
  return getSum(side - 2, side * side);
}
