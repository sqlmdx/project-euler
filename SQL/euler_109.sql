with
nums(n, m) as
(
	select n, m
	from generate_series(1, 20) n,
		 generate_series(1, 3) m
	union all
	select 25, generate_series(1, 2) m
	union all
	select 0, 0
),
checkout as
(
	select
		n1.m::text||'*'||n1.n::text x1,
		n2.m::text||'*'||n2.n::text x2,
		n3.m::text||'*'||n3.n::text x3,
		n1.n*n1.m + n2.n*n2.m + n3.n*n3.m total
	from nums n1
	join nums n2 on n1.m = 2
	join nums n3 on n2.n != 0 or n3.n = 0
)
select count(distinct x1 || greatest(x2, x3) || least(x2, x3)) result
from checkout
where total < 100;