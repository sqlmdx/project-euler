# p ^ q * q ^ p <= n ^ n 
# <=>
# log(p)/log(10) * q + log(q)/log(10) * p <= log(n)/log(10) * n

from sympy import isprime
from math import log

N = 800800

def f(p, q, n):
    return log(p)/log(10) * q + log(q)/log(10) * p - log(n)/log(10) * n

def get_limit(p, n):
    return int((log(n)/log(10) * n) / (log(p)/log(10)))

primes = [2] + [i for i in range(3, get_limit(2, N), 2) if isprime(i)]

def get_idx(primes, p, n, n1, n2):
    if n2 - n1 < 2:
        return n1
    else:
        half = ((n1 + n2) // 2)
        if f(p, primes[half], n) > 0:
            return get_idx(primes, p, n, n1, half)
        else:
            return get_idx(primes, p, n, half, n2)

max_idx = len(primes) - 1
cnt = 0
for i, p in enumerate(primes):
    idx = get_idx(primes, p, N, 0, max_idx)
    if idx > i:
        cnt += idx - i
    else:
        break
print(cnt)