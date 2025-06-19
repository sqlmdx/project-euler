with recursive
gen(lvl, n, prod) as
(
	select 1, i, i::numeric
	from generate_series(1, 1000) i
	union all
	select lvl + 1, n, n*prod % 10e10
	from gen
	where lvl < n
)
select right(sum(prod)::text, 10)
from gen
where lvl = n;