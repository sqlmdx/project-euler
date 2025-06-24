def chk(digits, total):
    if digits < total:
        return False
    if digits == total:
        return True
    if total > 0:
        tmp = 10
        while tmp < digits:
            if chk(digits // tmp, total - digits % tmp):
                return True
            tmp *= 10
    return False

N = 10**(12>>1)
total = 0
for n in range(2, N+1):
    if n % 9 > 1:
        continue
    if chk(n*n, n):
        print(f'{n} {n*n}')
        total += n*n
print(total)