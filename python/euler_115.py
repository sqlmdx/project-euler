from itertools import count
from functools import cache

@cache
def permutations(n, tiles):
    result = 0
    for tile in tiles:
        if n > tile:
            for i in range(0, n - tile + 1):
                result += 1 + permutations(n - tile - i - 1, tiles)
        elif n == tile:
            result += 1
    return result

N = 50
for i in count(N):
    tiles = range(N, i+1)
    if 1 + permutations(i, tiles) > 10**6:
        print(i)
        break