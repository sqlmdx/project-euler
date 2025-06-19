with recursive
r(lvl, n, i, b, str) as
(
	select 1, 1, 1, 2::numeric, '2.'
	union all
	select lvl+1,
			case when n=i then n+1 else n end,
			case when n=i then 1 else i + 1 end,
			case when n=i
				then trunc((str || trunc(b)::text)::numeric)
					* (mod((str || trunc(b)::text)::numeric, 1) + 1)
				else trunc(b) * (mod(b, 1) + 1)
			end,
			case when n=i then str || trunc(b)::text else str end
	from r
	where length(str) < 24 + length('2.')
)
select str::numeric(25, 24) result
from r
order by lvl desc
limit 1;