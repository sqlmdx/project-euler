from math import comb

def gen(limit, total, n, lvl, cc):
    if lvl < 10:
        for i in range(limit+1):
            if total + i <= n:
                for g in gen(limit, total + i, n, lvl+1, cc + (i, )):
                     yield g
    else:            
        if sum(cc) == n:
            yield cc

def calc(lst, n):
    result = 1
    agg = 0
    for cnt_digit in lst:
        result *= comb(n - agg, cnt_digit)
        agg += cnt_digit
    return result

N = 18
K = 3

result = sum(calc(x, N) for x in gen(K, 0, N, 0, ()))*9//10
print(result)