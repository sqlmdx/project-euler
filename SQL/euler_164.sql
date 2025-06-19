with recursive
gen(n, prev1, prev2, cnt) as
(
	select 20, i, 0, 1::numeric
	from generate_series(1, 9) i
	union all
	select distinct n-1, i, prev1, sum(cnt) over (partition by prev1, i)
	from gen, generate_series(0, 9-prev1-prev2) i
	where n > 1
)
select sum(cnt) result
from gen
where n = 1;