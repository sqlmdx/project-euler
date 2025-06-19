with t(id) as
(
select level + 1 from dual connect by level < 20  
),
m as
(
    select *
    from t
    model
    dimension by (id)
    measures (0 d, id x)
    rules
    iterate(19)
    ( 
        d[1] = iteration_number + 2,
        d[id < iteration_number + 2 and id > 1] order by id =
        case when mod(d[cv()-1], x[cv()]) = 0 then d[cv()-1] / x[cv()] else d[cv()-1] end,
        x[iteration_number + 2] = d[iteration_number + 1]
    )
)
select exp(sum(ln(x))) result
from m;