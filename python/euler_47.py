from euler_lib import get_prime_factors

k = 4
i = 2
while 1:
    i += 1
    j = 0
    while len(list(get_prime_factors(i+j))) == k:
        j += 1
    if j >= k:
        print(i)
        break