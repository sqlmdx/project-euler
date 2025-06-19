from functools import cache

f = open("..\\input\\0081_matrix.txt", "r")
matrix = ()
for i in f:
    matrix += (tuple(map(int, i.split(','))), )
f.close()

@cache
def min_path(m, i, j, n):
    if i < n and j < n:
        return (m[i][j], ) + min(min_path(m, i+1, j, n), min_path(m, i, j+1, n), key = lambda x: sum(x))
    elif i < n:
        return (m[i][j], ) + min_path(m, i+1, n, n)
    elif j < n:
        return (m[i][j], ) + min_path(m, n, j+1, n)    
    else:
        return (m[i][j], )

result = min_path(matrix, 0, 0, len(matrix)-1)
print(f'PATH: {result}')
print(sum(result))