"""
1/x + 1/y = 1/n

this means there are some integer a, b such as

1/(n + a) + 1/(n + b) = 1/n
=>
n * (n + b + n + a) = (n + a) * (n + b)
=>
2 * n * n + a * n + b * n = n * n + a * n + b * n + a * b
=>
n * n = a * b
"""

from euler_lib import get_prime_factors
from itertools import count

def cnt(n):
    result = 1
    for i, e in get_prime_factors(n):
        result *= 2*e + 1
    return (result + 1)//2

next(x for x in count(2) if cnt(x) > 1000)