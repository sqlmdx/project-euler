N = 2_000_000

arr = [None]*N

for i in range(2, N // 2 + 1):
    if arr[i-1] == None:
        for j in range(2, N // i + 1):
            arr[i*j-1] = 1

sum(i for i, e in enumerate(arr, 1) if e is None and i > 1)