with recursive
gen(lvl, n, flag) as
(
	select 1, n::text, 1
	from tprime where n < 1000000
	union all
	select lvl + 1, g.n, coalesce(t.n, 0)
	from gen g
	left join tprime t on t.n = (substr(g.n, lvl + 1) || left(g.n, lvl))::int
	where lvl < length(g.n) and flag != 0
)
select sum(1) result
from
(
	select n from gen group by n having min(flag) > 0
) t;