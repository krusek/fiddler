import bisect

UP = 'up'
DOWN = 'down'

def next_tuples(tuple):
    total, max, n, direction = tuple
    if n == 1 and direction == UP:
        return [(total + 2, 2, 2, UP)]
    if n == 1 and direction == DOWN:
        return []
    if direction == DOWN:
        return [(total + n - 1, max, n - 1, DOWN)]
    return [(total + n - 1, max, n - 1, DOWN), (total + n + 1, max + 1, n + 1, UP)]

# tuple (total, max, n, direction)
start_tuple = (1, 1, 1, UP)
def all_tuples(limit):
    processing = [start_tuple]
    count = 0
    while count < limit:
        item = processing.pop(0)
        yield item
        count += 1
        next = next_tuples(item)
        for item in next:
          bisect.insort(processing, item, key=lambda x: x[0])

current_value = 0
items = []
twos = []
for item in all_tuples(500):
    if len(items) == 3:
        twos.append(current_value)
    if current_value != item[0]:
        if len(items) > 1:
            print("%d, %s" % (len(items), items))
        current_value = item[0]
        items = [item]
    else:
        items.append(item)

def reduction(values):
    return map(lambda v: v[1] - v[0], zip(values, values[1:]))

while len(twos) > 2:
    print(twos)
    twos = list(reduction(twos))

def next_set(total, n):
    t = total + n + 1
    yield (t, n + 1, n + 1, UP)
    for ix in range(n, 0, -1):
        t += ix
        yield (t, n + 1, ix, DOWN)
    
def next_tuple(start_tuple):
    total, max, n, direction = start_tuple
    if n == 1 and direction == DOWN:
        return None
    if direction == UP:
        return (total + n + 1, max + 1, max + 1, UP)

# dictionary sum: [tuples]
counts = {1: [start_tuple]}

processing = [start_tuple]
key = lambda x: x(0)

items = list(next_set(start_tuple[0], start_tuple[1]))
start_tuple = items[0]
print(list(next_set(start_tuple[0], start_tuple[1])))
