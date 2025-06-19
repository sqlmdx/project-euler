from euler_lib import is_prime

def chk(n):
    for i in range(1, int((n // 2)**0.5) + 1):
        if is_prime(n - 2*i*i):
            return 1
    return 0

i = 3
while 1:
    i += 2
    if not is_prime(i):
        if not chk(i):
            print(i)
            break