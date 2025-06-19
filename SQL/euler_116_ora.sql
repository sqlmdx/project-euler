with m as
(
    select *
    from dual
    model
    ignore nav
    dimension by (0 id)
    measures (1 r, 1 g, 1 b)
    rules
    iterate(50)
    (
        r[iteration_number+1] = r[iteration_number] + r[iteration_number-1],
        g[iteration_number+1] = g[iteration_number] + g[iteration_number-2],        
        b[iteration_number+1] = b[iteration_number] + b[iteration_number-3]
    )
)
-- for each color we exclude one solution with zero tiles
select r+g+b-1-1-1 result
from m
where id = 50;