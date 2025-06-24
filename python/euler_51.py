from euler_lib import is_prime

def build_dict(mask, primes):
    result = {}
    for p in primes:
        first = 0
        flag = 1
        reduced = ''
        for idx, d in enumerate(mask):
            if d > '0':
                if first == 0:
                    first = str(p)[idx]
                if str(p)[idx] != first:
                    flag = 0
                    break
            else:
                reduced += str(p)[idx]
        if flag:
            if reduced in result:
                result[reduced][0] += 1
            else:
                result[reduced] = [1, p]
    return result

for n in range(2, 6 + 1):
    primes = [i for i in range(10**(n-1), 10**n) if is_prime(i)]
    for j in range(1, 2**(n - 1)):
        # least significant digit always without placeholder
        m = f'{j:0{n-1}b}' + '0'
        d = build_dict(m, primes)
        (cnt, smallest) = max(d.values(), key = lambda x: x[0])
        if cnt == 8:
            print(smallest)
            break