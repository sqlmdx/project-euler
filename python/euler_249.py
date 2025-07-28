from euler_lib import is_prime

M = 10**16
N = 5000
primes = [i for i in range(2, N) if is_prime(i)]

def build_dict(primes, m):
    result = [1] + [0] * sum(primes)
    total = 0
    for p in primes:
        for i in reversed(range(total + 1)):
            result[i + p] = (result[i + p] + result[i]) % m
        total += p
    return result

result = sum(n for i, n in enumerate(build_dict(primes, M)) if is_prime(i)) % M
print(result)