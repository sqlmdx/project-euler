with recursive
gen(n, a, b) as
(
	select (1e12 / 2)::bigint, 1::bigint, 0::bigint
	union all
	select
		n / 2,
		case when n % 2 = 0 then 2 * a + b else a end,
		case when n % 2 = 0 then -3 * b else -3 * a + 2 * b end	
	from gen
	where n > 1
)
select 4 - (a + 2 * b) result
from gen
where n = 1;