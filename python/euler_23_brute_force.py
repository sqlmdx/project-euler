# I was curious if there is real proof regarding 28123
# but most likely that is just "teasing statement"
# Some additional info: https://mathworld.wolfram.com/AbundantNumber.html

from euler_lib import get_prime_factors

N = 28123

def get_all_divisors(prime_factors):
    try:
        i, e = next(prime_factors)
        for g in get_all_divisors(prime_factors):
            for j in range(0, e + 1):
                yield i ** j * g
    except:
        yield 1

abundant = [i for i in range(1, N) if sum(list(get_all_divisors(get_prime_factors(i)))[:-1]) > i]

d = {}
for idx, i in enumerate(abundant):
    for j in abundant[idx:]:
        if i + j < N:
            d[i+j] = 1
        else:
            break

l = [i for i in range(1, N) if i not in d]
print(sum(l))