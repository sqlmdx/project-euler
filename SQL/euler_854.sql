-- https://oeis.org/A005013

with recursive
gen(k, v, a, b, c, d, m, q) as
(
	select 2,
			2::numeric,
			0::numeric,
			1::numeric,
			2::numeric,
			1::numeric,
			1234567891,
	        0::numeric
	union all
	select k + 2,
			v * (case when k % 4 = 0 then b else d end) % m,
			b,
			(a + b) % m,
			d,
			(c + d) % m,
			m,
			(case when k % 4 = 0 then b else d end) % m
	from gen
	where k <= 1e6
)
select v result
from gen
order by k desc
limit 1;