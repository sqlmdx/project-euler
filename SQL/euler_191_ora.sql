-- this can be solved with recursive CTE if we add 2 extra columns to keep previous values for "late"

with m as
(
    select *
    from dual
    model
    ignore nav
    dimension by (0 id)
    measures (1 result, 1 late, 1 abs1, 1 abs2)
    rules
    iterate(30)
    (
        result[iteration_number+1] = result[cv()-1] + late[cv()-1] + abs1[cv()-1],
        late[iteration_number+1] = sum(late)[id between cv()-3 and cv()-1] + decode(late[cv()-3], 0, 1, 0),
        abs1[iteration_number+1] = late[cv()-1] + abs1[cv()-1] + abs2[cv()-1] + abs2[cv()-3],
        abs2[iteration_number+1] = late[cv()-1] + abs1[cv()-1] + abs2[cv()-3]
    )
)
select result
from m
where id = 30;