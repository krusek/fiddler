contestants = 3
voters = 13

dictionary = {}
for i in range(contestants):
    dictionary[i] = 0

decisive = 0
total = 0


def process(dictionary: dict[int, int], count: int):
    global decisive, total, contestants, voters
    if count >= voters:
        for i in range(contestants):
            if dictionary[i] > voters / 2:
                decisive += 1
        total += 1
        return
    for i in range(contestants):
        dictionary[i] += 1
        process(dictionary, count + 1)
        dictionary[i] -= 1


def do_count(total_voters: int):
    global decisive, total, contestants, voters
    voters = total_voters
    decisive = 0
    total = 0
    process(dictionary, 0)
    print(decisive)
    print(total)
    print(100.0*decisive/total)


do_count(3)
do_count(3)
do_count(3)
do_count(3)
do_count(5)
do_count(7)
old_total = total
old_decisive = decisive
do_count(9)
print(total / old_total)
print(decisive / old_decisive)
old_total = total
old_decisive = decisive
do_count(11)
