from math import factorial, comb
from functools import cache

# https://mathworld.wolfram.com/PartialDerangement.html

@cache
def sub_factorial(n):
    return (n-1) * (sub_factorial(n-2) + sub_factorial(n-1)) if n > 2 else n-1

print(round(comb(25, 3) * sum(sub_factorial(100-3-i) * comb(100-25, i) for i in range(100-25+1)) / factorial(100), 12))