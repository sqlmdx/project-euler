with recursive
pal_div(i, n, stop) as
(
	select 999, 999, 0
	union all
	select
		case when stop = 0 then i - 1 else 999 end,
	    case when stop = 0 then n else n - 1 end,
		case when (n::text || reverse(n::text))::int % i = 0
	          and (n::text || reverse(n::text))::int / i between 100 and 999 then 1
	         when i = 100 then -1
	         else 0 end
	from pal_div
	where stop <> 1
)
select (n::text || reverse(n::text)) result
from pal_div
where stop = 1;