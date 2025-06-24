from math import comb

max(sum(list(map(int, str(a**b)))) for a in range(1, 100) for b in range(1, 100))