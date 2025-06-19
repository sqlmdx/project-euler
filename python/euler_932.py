from math import log, ceil

def chk(nn, n):
    tmp = 10**(ceil(log(n, 10))-1)
    while tmp < nn:
        n1 = nn // tmp
        n2 = nn % tmp
        if n2 > n:
            return False
        if n1 + n2 == n:
            if str(n1) + str(n2) == str(nn) and n2 > 0:
                return True
        tmp *= 10
    return False

n = 16
total = 0
for n in range(1, 10**(n>>1)):
    if n % 9 > 1:
        continue
    if chk(n*n, n):
        print(f'{n} {n*n}')
        total += n*n
print(total)