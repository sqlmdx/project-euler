with m as
(
    select *
    from dual
    model
    dimension by (0 id)
    measures (1 result, 1 generic)
    rules
    (
        -- manually found this formula
        result[for id from 3 to 50 increment 1] = nvl(result[cv()-1], 1) + nvl(result[cv()-2], 1)
        + decode(mod(cv(id), 3), 0, 0, decode(mod(trunc(cv(id) / 3), 2), 1, 1, -1)),
        -- found linear recurrence in an automated fashion (the same approach as in Problem 237/Problem 710)
        generic[for id from 3 to 50 increment 1] = 2 * nvl(generic[cv()-1], 1) - nvl(generic[cv()-2], 1)
        + nvl(generic[cv()-3-1], 1) 
    )
)
select result, generic
from m
where id = 50;