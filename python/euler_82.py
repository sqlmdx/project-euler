from functools import cache

f = open("..\\input\\0082_matrix.txt", "r")
matrix = ()
for i in f:
    matrix += (tuple(map(int, i.split(','))), )
f.close()

@cache
def min_path(m, i, j, n, prev_i):
    if j < n:
        if i < n and prev_i <= i and i > 0 and prev_i >= i:
            return (m[i][j], ) + min(min_path(m, i-1, j, n, i), min_path(m, i, j+1, n, i), min_path(m, i+1, j, n, i), key = lambda x: sum(x))
        elif i < n and prev_i <= i:
            return (m[i][j], ) + min(min_path(m, i, j+1, n, i), min_path(m, i+1, j, n, i), key = lambda x: sum(x))
        elif i > 0 and prev_i >= i:
            return (m[i][j], ) + min(min_path(m, i, j+1, n, i), min_path(m, i-1, j, n, i), key = lambda x: sum(x))
        else:
            return (m[i][j], ) + min_path(m, i, j+1, n, i)
    else:
        return (m[i][j], )

result = min([min_path(matrix, idx, 0, len(matrix)-1, idx) for idx in range(len(matrix))], key = lambda x: sum(x))
print(f'PATH: {result}')
print(sum(result))