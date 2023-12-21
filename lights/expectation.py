
import math
import random


def create_matrix(vars: int) -> list[list[int]]:
  return list(map(lambda _: [0]*(vars+1), range(vars)))

def set_value(var: int, target: int, matrix: list[list[int]]):
  if var >= target:
    return
  line = matrix[var]
  # first we increase the number of lights.
  if var < target:
    line[-1] += (target - var) 
    if var < target - 1:
      line[var + 1] = (target - var) 
  # next we decrease the number of lights.
  if var > 0:
    line[-1] += (var) 
    line[var-1] = (var) 
  line[var] = -target

def reduce_matrix(matrix: list[list[int]]):
  for i in range(len(matrix)):
    line = matrix[i]
    for j in range(len(matrix)):
      if i == j:
        continue
      other = matrix[j]
      line_mul = other[i]
      other_mul = line[i]
      matrix[j] = list(map(lambda x: line_mul*line[x] - other_mul*other[x], range(len(line))))

n = 7
equations = create_matrix(n)
for x in range(n):
  set_value(x, n, equations)
reduce_matrix(equations)

def abs(x: int) -> int:
  if x < 0:
    return -x
  return x

numerator = abs(equations[0][-1])
denominator = abs(equations[0][0])
gcd = math.gcd(numerator, denominator)
print(numerator//gcd, "/", denominator//gcd, " ~ ", numerator / denominator)

total = 0
count = 100_000
for i in range(count + 1):
  lanes = [-1]*n
  flips = 0
  while sum(lanes) < n:
    flips += 1
    laneFlip = random.randint(1, n)
    lanes[laneFlip-1] = lanes[laneFlip-1] * -1
  total += flips
print(total / count)

