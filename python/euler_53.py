from math import comb

print(sum(1 for n in range(1, 100+1) for r in range(1, n) if comb(n, r) > 10**6))