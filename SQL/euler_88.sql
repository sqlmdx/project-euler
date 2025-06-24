-- it takes more than a minute to run on my laptop

with recursive
gen(lvl, total, x, prod, summa) as
(
	select 1, id, n, id/n, id-n
	from generate_series(1, 12000 * 2) id, generate_series(2, id/2) n
	where id % n = 0
	union all
	select lvl + 1, total, n, r.prod / n, r.summa - n
	from gen r, generate_series(2, prod) n
	where r.prod % n = 0 and n >= r.x
),
tt as
(
	select summa + lvl n, min(total) total
	from gen
	where prod = 1 and summa + lvl <= 12000
	group by 1
)
select sum(distinct total)
from tt;