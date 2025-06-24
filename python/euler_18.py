# this solution is just for fun - to play with nodes and traverse trees :)
# for the right approach see Problem 67

input = (     '75',
             '95 64',
            '17 47 82',
           '18 35 87 10',
          '20 04 82 47 65',
         '19 01 23 75 03 34',
        '88 02 77 73 07 63 67',
       '99 65 04 28 06 16 70 92',
      '41 41 26 56 83 40 80 70 33',
     '41 48 72 33 47 32 37 16 94 29',
    '53 71 44 65 25 43 91 52 97 51 14',
   '70 11 33 28 77 73 17 78 39 68 17 57',
  '91 71 52 38 17 14 91 43 58 50 27 29 48',
 '63 66 04 68 89 53 67 30 73 16 69 87 40 31',
'04 62 98 27 23 09 70 98 73 93 38 53 60 04 23')

class node:
    def __init__(self, v, l, r):
        self.v = v
        self.l = l
        self.r = r

def get_max_total(n):
    total = 0
    def traverse(n, path):
        nonlocal total
        if n.l:
            traverse(n.l, path + (n.v, ))
        if not n.l and not n.r:
            curr = sum(path + (n.v, ))
            if curr > total:
                total = curr
        if n.r:
            traverse(n.r, path + (n.v, )) 
    traverse(n, ())
    return total

def to_nodes(arr):
    result = ()
    for i1, e1 in enumerate(arr):
        level_i = ()
        for i2, _ in enumerate(e1):
            level_i += (node(arr[i1][i2],
                             result[i1-1][i2] if i1 > 0 else None,
                             result[i1-1][i2+1] if i1 > 0 else None), )
        result += (level_i, )
    return result    

tree = ()
for i in input:
    tree += (tuple(map(int, i.split(' '))), )

tree_nodes = to_nodes(tuple(reversed(tree)))
        
depth = len(tree)
print(get_max_total(tree_nodes[depth - 1][0]))