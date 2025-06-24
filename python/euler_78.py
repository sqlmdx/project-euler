from itertools import count
from functools import cache

# https://mathworld.wolfram.com/PartitionFunctionP.html
# this is implemented in sympy https://docs.sympy.org/latest/modules/functions/combinatorial.html#sympy.functions.combinatorial.numbers.partition

@cache
def p(i):
    if i == 0:
        return 1
    result = 0
    for j in count(1):
        for k in (-1, +1):
            n = (3 * j * j + k * j) // 2
            m = 1 if j % 2 > 0 else -1
            if n > i:
                break
            result = (result + m * p(i - n)) % 10**6
        else:
            continue
        break
    return result

for i in count(1):
    if p(i) % 10**6 == 0:
        print(i)
        break