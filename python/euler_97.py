from functools import reduce

print((reduce(lambda x, _: (x * 2) % 10**10, [2]*7830457) * 28433+1) % 10**10) # or just (pow(2, 7830457, 10**10) * 28433 + 1) % 10**10