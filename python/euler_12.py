from euler_lib import get_prime_factors
from math import prod
from itertools import count, dropwhile

next(dropwhile(lambda n: prod([i + 1 for _, i in get_prime_factors(n)]) - 2 <= 500, (i*(i+1)//2 for i in count(1))))