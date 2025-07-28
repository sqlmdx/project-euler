# 4 step solution
# Step 1: brute force first few results
# Step 2: finding linear recurrence formula (apparently the sequence is https://oeis.org/A181688)
# Step 3: finding period
# Step 4: iterating till 10**12 % period to get the result
# it takes around 10 seconds to run with pypy

import time
start = time.time()

# Step 1

def routes(strt, grid, n, path):
    # if already visited
    if grid[strt] > 0:
        return 0
    # mark as visited
    tmp = list(grid)
    tmp[strt] = 1
    new_grid = tuple(tmp)
    # if arrived at bottom left corner
    if strt == 3*n:
        if sum(grid) == 4*n - 1:
            return 1
        else:
            return 0
    result = 0
    left = routes(strt-1, new_grid, n, path + (strt, )) if strt % n > 0 else 0
    right = routes(strt+1, new_grid, n, path + (strt, )) if strt % n < n-1 else 0
    up = routes(strt-n, new_grid, n, path + (strt, )) if strt // n > 0 else 0
    down = routes(strt+n, new_grid, n, path + (strt, )) if strt // n < 4-1 else 0
    result += left + right + up + down
    return result

K = 8 # or 10 - to check that T(10) = 2329
arr = [routes(0, (0, ) * (4*i), i, ()) for i in range(1, K+1)]
arr

# Step 2

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

N = 4
coeff = list(product(range(-N, N+1), repeat = N))
#list(get_formula(arr, coeff, N, K-1))
#[(2, 2, -2, 1)]

# Step 3

M = 10**8
MAX_N = 10**12

def get_period():
    a,b,c,d = 1,1,4,8
    for i in range(1, MAX_N):
        a,b,c,d=b,c,d,(2*d+2*c-2*b+a) % M
        if d == 8 and c == 4 and b == 1 and a == 1:
            return i

# Step 4

p = get_period()
limit = (MAX_N % p)
print(limit)
a,b,c,d = 1,1,4,8
for i in range(5, limit+1):
    a,b,c,d=b,c,d,(2*d+2*c-2*b+a) % M
print(d)

end = time.time()
print(f'{(end - start):.2f}')