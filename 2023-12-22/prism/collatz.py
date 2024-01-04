
evaluated = set()
evaluated.add(1)


def check_2024(n):
    global evaluated
    if n in evaluated:
        return False
    if n == 2024:
        return True
    evaluated.add(n)
    if n % 2 == 0:
        return check_2024(n / 2)
    else:
        return check_2024(3*n + 1)


for i in range(1, 2024):
    if check_2024(i):
        print(i)
        break
