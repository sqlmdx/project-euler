# brute force generator
def gen(n, s):
    if n > 0:
        yield s + (n, ) + tuple(reversed(s))
        for i in range(1, n//2+1):
            for g in gen(n-i*2, s + (i, )):
                yield g
    else:
        yield s + tuple(reversed(s))

def t0(n):
    return sum(x.count(2) > 0 for x in gen(n, ()))

# trying to find linear relation between t(i) and previous N members

from itertools import product

def reduce_coeff(arr, i, coeff):
    for option in coeff:
        if arr[i] == sum(c * arr[i-idx] for idx, c in enumerate(option, 1)):
            yield option

def get_formula(arr, coeff, start, stop):
    tmp_coeff = coeff
    for idx in range(start, stop+1):
        tmp_coeff = reduce_coeff(arr, idx, tmp_coeff)
    return tmp_coeff

K = 42
arr = [0] + [0]*K
for i in range(K):
    arr[i+1] = t0(i+1)

N = 5
coeff = list(product(range(-N, N+1), repeat = N))    

list(get_formula(arr, coeff, 10, 40))
#[(0, 3, 1, -2, -2)]

# now, with a formula it is trivial

from functools import cache
from itertools import count

@cache
def t(i):
    return arr[i] if i < N + 1 else (3*t(i-2) + t(i-3) - 2*t(i-4) - 2*t(i-5)) % 10**6

for i in count(42):
    if t(i) == 0:
        print(i)
        break