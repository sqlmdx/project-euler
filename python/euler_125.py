def gen(start, limit, lvl = 1):
    for i in range(start, (start if lvl > 1 else int((limit/2)**0.5)) + 1):
        if (i+1)*(i+1) < limit - i*i:
            for g in gen(i + 1, limit - i*i, lvl + 1):
                yield i*i + g
    if lvl > 1:
        yield start*start

sum(set([x for x in gen(1, 10**8) if str(x) == str(x)[::-1]]))