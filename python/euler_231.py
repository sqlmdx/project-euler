from sympy import primerange

def get_sum(n, k):
    result = 0
    for p in primerange(n):
        tmp = p
        while tmp <= n:
            if (n//tmp - k//tmp - (n - k)//tmp) == 1: result += p
            tmp *= p
    return result        

n = 2000000
k = 1500000

# this brute-force takes 10 minutes
# from euler_lib import get_prime_factors
# def getSumSeq(n1, n2):
#     return sum(sum(i * e for i, e in get_prime_factors(n)) for n in range(n1, n2 + 1))
# print(getSumSeq(max(n-k, k) + 1, n) - getSumSeq(1, min(n-k, k)))

print(get_sum(n, k))