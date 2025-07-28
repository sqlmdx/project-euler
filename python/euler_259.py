# Almost exactly the same as Problem 93 but a bit simpler as we have only one set of digits and we do not need to shuffle them.
# I reused code from Problem 93 with modification for the last loop in the code.
# It takes more than a minute to run on my laptop.

from functools import cache

E = 1e-9

def eval(x, y, op):
    if x == None or y == None:
        return None
    if op == '+':
        return x+y
    if op == '-':
        return x-y
    if op == '*':
        return x*y
    if op == '/':
        if abs(y) < E:
            return None
        else:
            return x/y

@cache
def get_targets(s):
    if len(s) == 1:
        yield s[0]
    for i in range(1, len(s)):
        for j in ('+','-','*','/'):
            new_s = s[:i-1] + (eval(s[i-1], s[i], j), ) + s[i+1:]
            for g in get_targets(new_s):
                yield g

from itertools import product

def get_substrings(s):
    for p in product(range(2), repeat=len(s)-1):
        curr = s
        for idx, e in enumerate(reversed(p)):
            if e == 1:
                idx = len(s) - idx - 1 
                curr = curr[:idx-1] + (int(str(curr[idx-1]) + str(curr[idx])), ) + curr[idx+1:]
        yield curr

N = 9
result = {0}
for c in get_substrings(tuple(range(1, N+1))):
    targets = get_targets(c)
    distinct_targets = set([round(r) for r in targets if r != None and r > 0 and abs(round(r) - r) < E])
    result |= distinct_targets
print(sum(result))