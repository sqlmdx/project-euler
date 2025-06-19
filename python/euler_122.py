def get_chains(lvl):
    accumulator = {}
    def get_chains_(lvl, chain):
        yield chain
        accumulator[chain[-1]] = len(chain)
        if lvl > 0:
            for x in chain:
                new_num = chain[-1]+x
                # we keep building chain only if new number was not observed before in shorter chain
                if new_num not in accumulator or accumulator[new_num] > len(chain):
                    for g in get_chains_(lvl - 1, chain + [new_num]):
                        yield g
    return get_chains_(lvl, [1])

# empirically we can check that recursive depth 11 produces chains for all numbers from 1 to 200
limit = 11
N = 200

d = {}
for k, v in [(chain[-1], len(chain)-1) for chain in get_chains(limit) if chain[-1] <= N]:
    d[k] = min((d[k] if k in d else limit + 1), v)

print(sum([x for _, x in d.items()]))