def min_divisor(n):
    sq = int(n ** (1/2))
    for i in range(2, sq + 1):
        if n % i == 0:
            return i
    return n

def is_prime(n):
    if n in (2, 3):
        return 1
    if n % 2 == 0 or n % 3 == 0 or n == 1:
        return 0
    # all primes > 3 are of the form 6n ± 1
    for i in range(6, int(n ** (1/2)) + 2, 6):
        if n % (i + 1) == 0 or n % (i - 1) == 0:
            return 0
    return 1

def get_prime_factors(n):
    m = min_divisor(n)
    if m > 1:
        e = 0
        while n % (m ** (e + 1)) == 0:
            e += 1
        yield m, e    
        for k, v in get_prime_factors(n // m ** e):
            yield k, v