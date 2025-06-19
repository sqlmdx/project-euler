def gen(nums):
    if len(nums) > 0:
        for i, n in enumerate(nums):
            for g in gen(nums[:i]+nums[i+1:]):
                yield str(n) + g
    else:
        yield ''

nums = range(0, 9 + 1)
g = gen(tuple(nums))
for _ in range(0, 10**6):
    tmp = next(g)
print(tmp)