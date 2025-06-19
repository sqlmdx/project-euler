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
        if y == 0:
            return None
        else:
            return x/y

def get_targets(s):
    if len(s) == 1:
        yield s[0]
    for i in range(1, len(s)):
        for j in ('+','-','*','/'):
            new_s = s[:i-1] + (eval(s[i-1], s[i], j), ) + s[i+1:]
            for g in get_targets(new_s):
                yield g

from itertools import combinations, permutations, count

def check_targets(tgt):
    for i in count(1):
        if tgt[i-1] != i:
            return i-1

result = []
for c in combinations(range(1, 10), 4):
    targets = []
    for p in permutations(c):
        targets += get_targets(p)
    distinct_targets = list(set([int(r) for r in targets if r != None and r > 0 and round(r) == r]))
    result += ((c, check_targets(distinct_targets)), )

best_target = sorted(result, key = lambda x: x[1], reverse = True)[0][0]
print(''.join(map(str, best_target)))