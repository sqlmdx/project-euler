from itertools import count, takewhile

def chk(i, x):
    y = (3*i + x)*(i - x)
    return (round(y**0.5))**2 == y

result = (
    sum(takewhile(lambda _: _ < 10**9, (3*(n*n+1)+1 for n in count(2) if chk(n*n+1, +1)))) +
    sum(takewhile(lambda _: _ < 10**9, (3*(2*n*n-1)-1 for n in count(2) if chk(2*n*n-1, -1)))))
print(result)