with recursive gen(lvl, n, total, txt) as
(
	select 1, n, n*n, n::text
	from generate_series(1, sqrt(1e8/2)::int) n
	union all
	select lvl + 1, (n+1), total + (n+1)*(n+1), txt || ',' || (n+1)::text
	from gen g
	where total + (n+1)*(n+1) < 1e8
)
select sum(distinct total) result
from gen
where lvl > 1
and total::text = reverse(total::text);