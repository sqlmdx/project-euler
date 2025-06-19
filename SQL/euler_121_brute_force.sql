with recursive
p as
(
	select perm, n, case when substring(perm, n, 1)::int = 1 then n/(n::real+1) else 1/(n::real+1) end prob
	from (select n::bit(15) perm from generate_series(0, power(2, 15)::int - 1) n) g, generate_series(1, 15) n
),
r as
(
	select perm, n, prob
	from p
	where n = 1
	union all
	select p.perm, p.n, r.prob*p.prob
	from r
	join p on r.n + 1 = p.n and r.perm = p.perm
)
select trunc(1 / sum(case when regexp_count(perm::text, '1') < 15::real/2 then prob end)) result
from r
where n = 15;