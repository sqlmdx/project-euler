from sympy import primerange

def pisanoPeriod(n, limit = 0):
    limit = limit + 1 if limit > 0 and limit < n * n else n * n
    previous, current = 0, 1
    for i in range(0, limit):
        previous, current = current, (previous + current) % n
        if (previous == 0 and current == 1):
            return i + 1
    return i + 1
    
primes = [p for p in primerange(1, 10**6) if 120 % pisanoPeriod(p, 120) == 0]

# there are no prime numbers n above 10**6 such as 120 % pisanoPeriod(n) == 0
# however interestingly there are still some numbers n which have pisanoPeriod(n) < 120
# primes = [(p, pisanoPeriod(p, 120)) for p in primerange(10**6, 10**7) if pisanoPeriod(p, 120) < 121]
# [(3010349, 62), (54018521, 74), (370248451, 82), (599786069, 98)]

# UPDATE
# apparently the largest number with pisanoPeriod = 120 is gcd(Fib(120), Fib(120+1)-1) = 1_548_008_755_920
# all oher numbers with pisanoPeriod = 120 can be geberated by permutations of prime factors of above number

def gen(nums, x, n):
    for i, e in enumerate(nums):
        if e * x <= n:
            yield e * x
            for g in gen(nums[i:], e * x, n):
                yield g

result = sum([i for i in gen(primes, 1, 10**9) if pisanoPeriod(i, 120) == 120])
print(result)