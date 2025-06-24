a = '1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679'
b = '8214808651328230664709384460955058223172535940812848111745028410270193852110555964462294895493038196'

from itertools import takewhile

L = len(a)

def gen_fib():
    a = 1
    b = 1
    while 1:
        yield a
        a, b = b, a + b

def get_digit(n):
    last = 1
    nums = list((i, x*L) for i, x in enumerate(takewhile(lambda x: x*L < n, gen_fib())))[2:]
    for i, num in reversed(nums):
        if n - num > 0:
            n -= num
            last = i
        if n < 2*L:
            break
    return ((b+a) if last % 2 == 0 else (a+b))[n-1]

print(''.join(get_digit((127 + 19*i) * 7**i) for i in range(17, -1, -1)))