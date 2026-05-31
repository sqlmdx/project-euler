# It takes about a minute to run on my laptop

import time
import numpy as np
from numba import njit

@njit
def get_cnt(N):
    N = int(N)
    mask = np.zeros(N, np.uint8)

    for p, k in enumerate((1, 2, 3, 7)):
        bit = 1 << p
        i = 1
        while True:
            ii = i * i
            if ii >= N:
                break
            j = 1
            while True:
                n = ii + k * j * j
                if n >= N:
                    break
                mask[n] = mask[n] | bit
                j += 1
            i += 1

    return (mask == 15).sum()

N = 2e9
start = time.time()
print(get_cnt(N))
end = time.time()
print(f'{(end - start):.2f}')

"""
version compatible with pypy (replacing np.zeros with bytearray)
execution time is very similar

def get_cnt(N):
    N = int(N)
    mask = bytearray(N)

    for p, k in enumerate((1, 2, 3, 7)):
        bit = 1 << p
        i = 1
        while True:
            ii = i * i
            if ii >= N:
                break
            j = 1
            while True:
                n = ii + k * j * j
                if n >= N:
                    break
                mask[n] = mask[n] | bit
                j += 1
            i += 1

    return mask.count(15)
"""