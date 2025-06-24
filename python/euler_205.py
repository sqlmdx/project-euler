def gen(c, n):
    if c == 0:
        yield ()
    else:
        for i in range(1, n + 1):
            for g in gen(c - 1, n):
                yield (i, ) + g

from collections import defaultdict
pp = defaultdict(int)
for a in gen(9, 4):
    pp[sum(a)] += 1
dd = defaultdict(int)
for a in gen(6, 6):
    dd[sum(a)] += 1

total = sum(v1 * v2 for k1, v1 in pp.items() for k2, v2 in dd.items() if k1 > k2)

print(round(total/(4**9 * 6**6),7))