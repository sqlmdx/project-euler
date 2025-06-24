with recursive 
gen(lvl, x1, x2, x3, x4) as
(
    select 0, 0::bigint, 0::bigint, 0::bigint, 1::bigint
    union all
    select lvl+1, x2, x3, x4, x1+x2+x3+x4
    from gen
    where lvl < 50
)
select x4 result
from gen
where lvl = 50;