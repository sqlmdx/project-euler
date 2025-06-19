with recursive gen as
(
	select 1 lvl, 1::numeric num, 2::numeric denom
	union all
	select lvl + 1, denom, 2*denom + num
	from gen
	where lvl < 1000
)
select sum(length((num+denom)::text) - length(denom::text)) result
from gen;