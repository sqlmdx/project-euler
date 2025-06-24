from euler_lib import is_prime

N = 1000000
primes = tuple(i for i in range(2, N) if is_prime(i))

def get_len(primes, i):
    m = 0
    m_total = 0
    total = primes[i]
    j = 1
    while i + j < len(primes):
        total += primes[i + j]
        j += 1
        if total >= N:
            break
        if is_prime(total):
            m = j
            m_total = total
    return m, m_total

sorted([get_len(primes, i) for i, p in enumerate(primes) if p < N // 2], key = lambda x: x[0])[-1][1]