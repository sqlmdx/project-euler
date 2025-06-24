from euler_lib import is_prime
from itertools import count

def gen(lvl, mlvl):
    if lvl == 0:
        yield ''
    else:
        r = '13' if lvl in (1, mlvl) else '0123'
        for d in r:
            for g in gen(lvl-1, mlvl):
                yield g + d

def get_sum(n):
    cnt = 0
    result = 0
    for n in count(2):
        for g in sorted(gen(n, n)):
            x1 = int(g)
            x2 = int(g[::-1])
            if x1 != x2 and str(x1*x1) == str(x2*x2)[::-1]:
                if is_prime(x1) and is_prime(x2):
                    result += x1*x1
                    cnt += 1
                    if cnt == 50:
                        return(result)

print(get_sum(50))