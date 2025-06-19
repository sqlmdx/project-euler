def gen(coins, x, n, lvl):
    for i, c in enumerate(coins):
        if c + x == n:
            yield c + x
        elif c + x < n:
            for g in gen(coins[i:], c + x, n, lvl + 1):
                yield g

len(list(gen((1, 2, 5, 10, 20, 50, 100, 200), 0, 200, 1)))