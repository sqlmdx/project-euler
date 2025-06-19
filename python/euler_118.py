from euler_lib import is_prime
from itertools import permutations

def get_prime_sets(s, prev):
    if len(s) == 0:
        yield ()
    else:
        for i in range(len(s)):
            curr = int(s[:i+1])
            if is_prime(curr) and curr > prev:
                for j in get_prime_sets(s[i+1:], curr):
                    yield (s[:i+1], ) + j

a = "123456789"

result = 0
for j in permutations(a):
    for g in get_prime_sets(''.join(j), 1):
        result += 1
print(result)