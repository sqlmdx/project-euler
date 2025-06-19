from euler_lib import is_prime

def gen(nums):
    if len(nums) > 0:
        for i, n in enumerate(nums):
            for g in gen(nums[:i]+nums[i+1:]):
                yield str(n) + g
    else:
        yield ''

result = 0
for i in range(4, 9 + 1):
    nums = range(1, i + 1)
    for i in gen(tuple(nums)):
        if is_prime(int(i)):
            result = i
print(result)