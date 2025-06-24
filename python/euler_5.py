# complexity for nested loops is O(n^2) so there are much better alternatives

N = 20
l = [None] * (N-1)
for i in range(0, N-1):
    tmp = i+2
    for j in range(0, i-1):
        if tmp % l[j] == 0:
            tmp //= l[j]
    l[i] = tmp

import math
print(math.prod(l))

# or just :)
math.lcm(*range(2, N + 1))