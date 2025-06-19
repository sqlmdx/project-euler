with recursive
gen(lvl, strt, n) as
(
	select 1, n::numeric, n + reverse(n::text)::numeric
	from generate_series(1, 10000 - 1) n
	union all
	select lvl + 1, strt, n + reverse(n::text)::numeric
	from gen
	where lvl < 50 and n != reverse(n::text)::numeric
)
select sum(1) result
from gen
where lvl = 50;