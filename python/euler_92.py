def digit_sum_sq(n):
    s = 0
    while n > 0:
        s += (n % 10) ** 2
        n = n // 10
    return s    

def get_finish(n):
    while n not in (1, 89):
        n = digit_sum_sq(n)
    return n

from collections import defaultdict
from functools import cache
@cache
def build_dict(cnt_d):
    result = defaultdict(int)
    if cnt_d == 1:
        for i in range(0, 9 + 1):
            result[i*i] = 1
    else:
        for i in range(0, 9 + 1):
            for k, v in build_dict(cnt_d - 1).items():
                result[k + i*i] += v
    return result

d = build_dict(7)
del(d[0])

result = 0
for k, v in d.items():
    if get_finish(k) == 89:
        result += v
print(result)