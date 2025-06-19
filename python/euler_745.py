nn = 10**14
n = int(nn**0.5)
arr = [None]*(n+1)
for i in range(n):
    arr[n-i] = nn//((n-i)**2) - sum(arr[(n-i)*j] for j in range(2, n//(n-i)+1))
print(sum(i*i*arr[i] for i in range(1, n+1)) % 1_000_000_007)