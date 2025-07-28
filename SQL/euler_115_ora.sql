with m as
(
    select *
    from dual
    model
    dimension by (50 id)
    measures (2 generic)
    rules
    iterate(1e9) until (generic[iteration_number + 50 + 1] > 1e6)
    (
        generic[iteration_number + 50 + 1] = 2 * nvl(generic[cv()-1], 1) - nvl(generic[cv()-2], 1)
        + nvl(generic[cv()-50-1], 1) 
    )
)
select max(id) result
from m;