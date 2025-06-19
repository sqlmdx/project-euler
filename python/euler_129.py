from itertools import count, dropwhile

def a(n):
    if n % 2 == 0 or n % 5 == 0:
        return 0
    r = 1
    acc = 1
    for i in count(2):
        r = (r * 10) % n
        acc = (acc + r) % n
        if acc == 0:
            return i

print(next(dropwhile(lambda x: a(x) < 1000001, count(1000000))))