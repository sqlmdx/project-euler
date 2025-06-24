from euler_lib import is_prime

def cnt_primes(ab):
    a, b = ab
    i = 0
    while 1:
        n = i * i + a * i + b
        if n > 0 and is_prime(n):
            i += 1
        else:
            break
    return i    

a, b = max(((a, b) for b in range(2, 1000+1) for a in range(-b, 1000)), key = cnt_primes)
print(a * b)