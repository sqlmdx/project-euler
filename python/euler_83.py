f = open("..\\input\\0083_matrix.txt", "r")
matrix = ()
for i in f:
    matrix += (tuple(map(int, i.split(','))), )
f.close()

INFINITY = 10**10

def min_path_dijkstra(grid):
    n = len(grid)
        
    cost = [[INFINITY] * n for _ in range(n)]
    cost[0][0] = grid[0][0]
    
    up, down, left, right = (-1, 0), (1, 0), (0, -1), (0, 1)
    
    cnt = 0
    q = [(0, 0)]
    while len(q) > 0:
        (i, j), q = q[0], q[1:]
        
        for d in (up, down, left, right):
            cnt += 1
            x, y = i + d[0], j + d[1]
            if not (x >= 0 and x < n and y >= 0 and y < n):
                continue
            if cost[i][j] + grid[x][y] < cost[x][y]:
                cost[x][y] = cost[i][j] + grid[x][y]
                q += [(x, y)]

    print(f'Iterations: {cnt}')
    return cost[n - 1][n - 1]

def min_path_bellman_ford(grid):
    n = len(grid)

    cost = [[INFINITY] * n for _ in range(n)]
    cost[0][0] = grid[0][0]

    up, down, left, right = (-1, 0), (1, 0), (0, -1), (0, 1)

    cnt = 0
    changed = True
    while changed:
        changed = False
        for i in range(n):
            for j in range(n):
                tmp = []
                for d in (up, down, left, right):
                    cnt += 1
                    x, y = i + d[0], j + d[1]
                    if not (x >= 0 and x < n and y >= 0 and y < n):
                        continue
                    tmp += [cost[x][y]]
                new_cost = grid[i][j] + min(tmp)
                if new_cost < cost[i][j]:
                    cost[i][j] = new_cost
                    changed = True
    
    print(f'Iterations: {cnt}')
    return cost[n - 1][n - 1]

min_path_dijkstra(matrix)

min_path_bellman_ford(matrix)