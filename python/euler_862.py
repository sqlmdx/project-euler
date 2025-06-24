# similar approach to Problem 172 but slightly different logic

from math import factorial

def gen(total, n, lvl, cc):
    if lvl < 10:
        for i in range(n+1):
            if total + i <= n:
                for g in gen(total + i, n, lvl+1, cc + (i, )):
                     yield g
    else:            
        if sum(cc) == n:
            yield cc

def calc(lst, n):
    result = factorial(n - 1)*(n - lst[0])
    for i in range(10):
        result //= factorial(lst[i])
    return result*(result-1)//2

N = 12

result = sum(calc(x, N) for x in gen(0, N, 0, ()))
print(result)