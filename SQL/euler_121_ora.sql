with m as
(
    select *
    from dual
    model
    ignore nav
    dimension by (0 id)
    measures (1 tmp, 0 num, 1 denom)
    rules
    iterate(15)
    (
        num[for id from 0 to iteration_number+1 increment 1] = tmp[cv()] * (iteration_number + 1) + tmp[cv()-1],
        tmp[id <= iteration_number+1] = num[cv()],
        denom[iteration_number+1] = denom[iteration_number] * (iteration_number + 2)
    )
)
select trunc(max(denom) / sum(case when id > 15/2 then num end)) result
from m;