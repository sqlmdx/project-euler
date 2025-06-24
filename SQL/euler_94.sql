with recursive
gen1(lvl, x0, x1)
as
(
	select 1, 0::numeric, 2::numeric
	union all
	select lvl + 1, x1, x1*4 - x0
	from gen1
	where (x1*x1+1)*3+1 < power(10, 9)
),
gen2(lvl, x0, x1)
as
(
	select 1, 1::numeric, 3::numeric
	union all
	select lvl + 1, x1, x1*4 - x0
	from gen2
	where (2*x1*x1-1)*3-1 < power(10, 9)
)
select sum(p) result
from
(
	select x0, (x0*x0+1)*3+1 p from gen1 where lvl > 1
	union all
	select x0, (2*x0*x0-1)*3-1 p from gen2 where lvl > 1
) t;