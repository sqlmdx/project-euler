from functools import cache

@cache
def p(p1, p2, is_p1_turn):
    if p1 == 100: return 0
    if p2 >= 100: return 1
    
    if is_p1_turn == 1:
        return p(p1, p2, False)/2 + p(p1 + 1, p2, False)/2

    return max(p_p2_wins * p(p1, p2 + 2**(n-1), True) + (1 - p_p2_wins) * p(p1 + 1, p2, False)
               for n, p_p2_wins in [(n, 2/(2**n+1)) for n in range(1, 8+1)])

print(round(p(0, 0, True), 8))