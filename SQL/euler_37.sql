with recursive
gen(lvl, n, flag) as
(
	select 1, n::text, 1
	from tprime where n between 11 and 1000000
	union all
	select lvl + 1, g.n, coalesce(tr.n + tl.n, 0)
	from gen g
	left join tprime tr on tr.n = right(g.n, lvl)::int
	left join tprime tl on tl.n = left(g.n, lvl)::int	
	where lvl < length(g.n) and flag != 0
)
select sum(n) result
from
(
	select n::int from gen group by n having min(flag) > 0
) t;