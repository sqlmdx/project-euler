from euler_lib import is_prime
from functools import cache

limit = 10000
primes = [i for i in range(2, limit) if is_prime(i)]

@cache
def is_combined_prime(n1, n2):
    return is_prime(int(str(n1) + str(n2))) and is_prime(int(str(n2) + str(n1)))

def chk(selected, candidate):
    for p in selected:
        if not is_combined_prime(p, candidate):
            return 0
    return 1    

def get_min_sum(n):
    min_sum = 10 ** 10
    def gen(shift, selected, n):
        nonlocal min_sum
        if min_sum < 10**10:
            if sum(selected) > min_sum:
                return
        if n > 0:
            m = shift + 1
            for i, p in enumerate(primes[m:]):
                if chk(selected, p):
                    for g in gen(i + m, selected + (p, ), n - 1):
                        yield g
        else:
            min_sum = sum(selected)
            yield selected
    return sum(min(gen(-1, (), n), key = sum))

print(get_min_sum(5))