with recursive
gen(lvl, n, d) as
(
	select 1, i, 10 % i
	from generate_series(2, 1000) i
	where i % 2 > 0 and i % 5 > 0
	union all
	select lvl + 1, n, 10 * d % n
	from gen
	where d > 1
)
select n result
from gen
group by n
order by max(lvl) desc
limit 1;