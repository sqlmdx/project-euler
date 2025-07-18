from functools import cache

@cache
def get_cnt(n, l, a):
    if n > 0:
        return (
            # late
            (get_cnt(n-1, 1, 0) if l == 0 else 0) +
            # absent
            (get_cnt(n-1, l, a+1) if a < 2 else 0) +
            # on time
            get_cnt(n-1, l, 0)
        )        
    else:
        return 1

result = get_cnt(30, 0, 0)
print(result)