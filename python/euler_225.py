from itertools import count, islice

def is_non_divisor(n):
    t1, t2, t3 = 3, 1, 1
    for _ in range(n*n):
        t1, t2, t3 = (t1 + t2 + t3) % n, t1, t2
        if t1 == 0:
            return False
        if (t1, t2, t3) == (1, 1, 1):
            return True

N = 124
print(next(islice((n for n in (count(1, 2)) if is_non_divisor(n)), N-1, N)))