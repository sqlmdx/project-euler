with recursive
gen(lvl, f1, f2, s1, s2) as
(
	select 1, 2::bigint, 1::bigint, 2::bigint, 1::bigint
	union all
	select lvl + 1, f1 + f2, f1, s1 + s2 + f2 - 1, s1
	from gen
	where f2 < 1e17
),
reduce(lvl, f, s, n, result) as
(
	select lvl, f2, s2, 1e17-1, 0::numeric
	from gen
	where lvl = (select max(lvl) from gen)
	union all
	select
		g.lvl, g.f2, g.s2,
		n - case when n >= g.f2 then g.f2 else 0 end,
		result + case when n >= g.f2 then g.s2 + n - g.f2 else 0 end
	from reduce r, gen g
	where g.lvl + 1 = r.lvl
)
select result
from reduce
where lvl = 1;