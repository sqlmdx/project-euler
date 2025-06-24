from euler_lib import is_prime
from collections import defaultdict
from itertools import count

primes = [n for n in range(2, 100) if is_prime(n)]

def gen(primes, x, n, lvl, comb):
    for i, c in enumerate(primes):
        if c + x < n:
            yield comb + (c, )
            for g in gen(primes[i:], c + x, n, lvl + 1, comb + (c, )):
                yield g

limit = 5000

def get_first_above_limit(limit):
    for n in count(2):
        d = defaultdict(int)
        for lst in (gen(primes[:n], 0, primes[n], 1, ())):
            total = sum(lst)
            d[total] += 1
        try:
            return min([k for k, v in d.items() if v > limit])
        except:
            continue

print(get_first_above_limit(limit))