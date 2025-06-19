from itertools import count
from euler_lib import is_prime

from collections import defaultdict

def build_dict(cnt_digits, extra):
    dd = {}
    for n in range(cnt_digits):
        prev = dd
        dd = defaultdict(int)
        for i in range(10):
            if n == 0:
                dd[i] = 1
            else:
                for k in prev.keys():
                    dd[k+i] += prev[k]
    result = {}
    for k in dd.keys():
        result[k+extra] = dd[k]
    return result

def get_cnt_prime(cnt_digit, extra):
    return sum(v for (k, v) in build_dict(cnt_digit, extra).items() if is_prime(k))

def normalize(result, extra, delta):
    if delta > 0:
        # if delta primes are left then roll up
        for i in range(10):
            if is_prime(extra+i):
                delta -= 1
            if delta == 0:
                break
        result += i
    else:
        # if nothing is left then roll down
        for i in range(1, 9):
            if is_prime(extra-1+10-i):
                break
        result -= i
    return result

def get_nth(n):
    for i in count(1):
        cnt = get_cnt_prime(i, 0)
        if cnt > n:
            break
        limit = i
    x = 0
    extra = 0
    for i in range(limit):
        tmp_agg = 0
        for j in range(10):
            tmp = get_cnt_prime(limit-i, extra+j)
            if tmp_agg + tmp > n:
                break
            tmp_agg += tmp
        n -= tmp_agg
        x += 10**(limit-i) * j
        extra += j
    return normalize(x, extra, n) 

get_nth(61)
get_nth(10**8)
get_nth(10**16)