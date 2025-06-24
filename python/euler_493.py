from math import comb

c = 7
n = 10
b = 20

print(round(c*(1-(comb(n*(c-1),b)/comb(c*n,b))), 9))