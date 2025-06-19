from math import gcd

# solution is absolutely trivial with the formula for fixed points (unconcealed messages)
# https://www.sciencedirect.com/science/article/pii/S0304397509006902

def unconcealed(e, p, q):
    return (1 + gcd(e - 1, p - 1)) * (1 + gcd(e - 1, q - 1))

p = 1009
q = 3643
phi = (p-1)*(q-1)
arr = [(i, unconcealed(i, p, q)) for i in range(1, phi, 2) if gcd(i, phi) == 1]
mi = min(x for (_, x) in arr)
print(sum(i for (i, x) in arr if x == mi))