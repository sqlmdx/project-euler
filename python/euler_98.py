from collections import defaultdict
from itertools import permutations

f = open("..\\input\\0098_words.txt", "r")
words = ()
for i in f:
    words += tuple(i.replace('"','').split(','))
f.close()

d = defaultdict(tuple)
for word in words:
    d[''.join(sorted(word))] += (word, )

def get_max_num(candidates):
    key = ''.join(set(candidates[0]))
    for i in permutations(range(0, 10), len(key)):
        cnt = 0
        p = ''.join(map(str,i ))
        for c in candidates:
            s = c.translate(str.maketrans(key, p))
            if s[0] == '0':
                continue
            num = int(s)
            if round(num**0.5)**2 == num:
                cnt += 1
        if cnt == 2:
            for c in candidates:
                yield int(c.translate(str.maketrans(key, p)))

max_num = 0
max_len = 0
for k, v in sorted([(k, v) for k, v in d.items() if len(v) > 1], key = lambda x: len(x[0]), reverse = True):
    if len(v) < max_len:
        break
    nums = list(get_max_num(v))
    if len(nums) > 0:
        max_num = max(max_num, max(nums))
        max_len = len(nums)
print(max_num)