from functools import cache

@cache
def get_cnt(n, lower, limit, prev1, prev2):
    return sum(get_cnt(n-1, 0, limit, i, prev1) for i in range(lower, 1+limit-prev1-prev2)) if n > 0 else 1

result = get_cnt(20, 1, 9, 0, 0)
print(result)