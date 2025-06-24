from euler_lib import is_prime
from itertools import accumulate, dropwhile, count

# this can be written as one liner but does not look very attractive :)
cnt_prime = lambda i: sum(is_prime((i*2+1)**2 - j*2*i) for j in range(0, 4))
gen = (accumulate(((i, cnt_prime(i)) for i in count(1)), lambda x, y: (2*y[0], x[1] + y[1])))
next(dropwhile(lambda x: 10*x[1]/(x[0]*2+1) >= 1, gen))[0]+1