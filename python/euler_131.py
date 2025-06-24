from euler_lib import is_prime

i = 1
total = 0
for p in range(1_000_000):
    j = i**3
    x = j + p
    if round(x**(1/3))**3 == x:
        if is_prime(p):
            total += 1
        i += 1
print(total)