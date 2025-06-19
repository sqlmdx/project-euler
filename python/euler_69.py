from sympy import primerange
from itertools import accumulate, takewhile
from operator import mul

max(takewhile(lambda _: _ < 10**6, accumulate(primerange(2, 10**6), mul)))