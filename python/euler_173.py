N = 1000000

result = 0
for i in range(1, N // 4):
    total = 0
    for j in range(i+2, N // 4 + 2, 2):
        total += j*2 + (j-2)*2
        if total <= N:
            result += 1
        else:
            break
print(result)