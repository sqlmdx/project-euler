def r(a):
    a2 = a**2
    ap1 = a + 1
    am1 = a - 1
    yield (ap1 + am1) % a2
    api = (ap1 * ap1) % a2
    ami = (am1 * am1) % a2    
    y = (api + ami) % a2
    yield y
    while not (api == 1 and ami == 1):
        api = (api * ap1) % a2
        ami = (ami * am1) % a2
        y = (api + ami) % a2        
        yield y

print(sum(max(r(i)) for i in range(3, 1000 + 1)))