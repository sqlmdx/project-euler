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

N = 10000000
from collections import defaultdict
d = defaultdict(int)
for i in range(1, N + 1):
    d[digit_sum_sq(i)] += 1

result = 0
for k, v in d.items():
    if get_finish(k) == 89:
        result += v

print(result)