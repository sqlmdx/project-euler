"""

Below table contains elapsed time in seconds for the second run

+------------+-----------------------+-----------------------+
|            |         2^40          |         2^50          |
|            +------------+----------+------------+----------+
|            |   native   |   pypy   |   native   |   pypy   |
+------------+------------+----------+------------+----------+
| Mobius     |    181     |    31    |     -      |  1180    |
+------------+------------+----------+------------+----------+
| Mobuisrange|      0.5   |     0.06 |     16.5   |     1.7  |
+------------+------------+----------+------------+----------+
| Sieve      |      0.04  |    -     |      2.8   |    -     |
+------------+------------+----------+------------+----------+

"""

from math import isqrt
from sympy import mobius, sieve
from util import time_it_decorator

p = 40
N = 2**p

@time_it_decorator
def f_mobius(n):
    limit = isqrt(n) + 1
    return sum(mobius(i) * (n//(i*i)) for i in range(1, limit))

@time_it_decorator
def f_mobiusrange(n):
    limit = isqrt(n) + 1
    return sum(m * (n//(i*i)) for i, m in enumerate(sieve.mobiusrange(1, limit), 1))

from numba import jit
import numpy as np

@time_it_decorator
@jit
def f_sieve(N):
    sieve  = np.full(int(N**.5)+1, 1, dtype=np.int64)
    for i in range(len(sieve), 0, -1):
        sieve[i] = N//(i**2) - np.sum(sieve[2*i :: i])
    return sieve[1]

print(p)

# first run
print(f_mobius(N))
print(f_mobiusrange(N))
print(f_sieve(N))

# second run
print(f_mobius(N))
print(f_mobiusrange(N))
print(f_sieve(N))