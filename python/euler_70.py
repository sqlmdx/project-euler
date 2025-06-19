N = 10**7

arr = list(range(N + 1))

for i in arr:
    if i < 2 or arr[i] != i:
        continue
    for j in range(1, N // i + 1):
        idx = i * j
        arr[idx] -= arr[idx] // i

result = min([(n, phi) for (n, phi) in enumerate(arr[2:], 2) if sorted(str(n)) == sorted(str(phi))], key = lambda x: x[0] / x[1])
print(result[0])