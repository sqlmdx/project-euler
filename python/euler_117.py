from functools import cache

N = 50
tiles = range(2, 4+1)

@cache
def permutations(n, tiles):
    result = 0
    for tile in tiles:
        if n > tile:
            for i in range(0, n - tile + 1):
                result += 1 + permutations(n - tile - i, tiles)
        elif n == tile:
            result += 1
    return result

print(1 + permutations(N, tiles))