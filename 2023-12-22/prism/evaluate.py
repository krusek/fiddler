
from math import sqrt


max_volume = 0
value = None
target = 2024*2024
for i in range(1, 2024):
    i2 = i*i
    for j in range(i, 2024):
        j2 = j*j
        k2 = target - i2 - j2
        if k2 < 0:
            break
        k = int(sqrt(k2))
        if k*k == k2:
            volume = i*j*k
            print((i, j, k))
            print(volume)
            if volume > max_volume:
                max_volume = volume
                value = [(i, j, k)]
            if value == max_volume:
                value += [(i, j, k)]

print("max volume")
print(max_volume)
print(value)
