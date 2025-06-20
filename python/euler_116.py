from functools import cache

N = 50
tiles = range(2, 4+1)

# version 1

@cache
def permutations(n, tile, cnt):
    result = 0
    if cnt > 0:
        for i in range(1, n - tile*cnt + 2):
            result += permutations(n-tile-i+1, tile, cnt-1)
        return result    
    else:
        return 1

result = 0
for tile in tiles:
    for i in range(1, N // tile + 1):
        result += permutations(N, tile, i)
print(result)

# version 2

@cache
def permutations(n, tile):
    result = 0
    if n > tile:
        for i in range(0, n - tile + 1):
            result += 1 + permutations(n - tile - i, tile)
    elif n == tile:
        result = 1
    return result

print(sum(permutations(N, i) for i in tiles))