from euler_lib import get_prime_factors

def phi(n):
    for i, _ in get_prime_factors(n):
        n -= n // i
    return n

N = 1000000
max(range(2, N + 1), key = lambda x: x / phi(x))
