-- it takes aroud 4 minutes to run on my laptop
-- with "numeric" instead of "double precision" runtime jumps to ~6 minutes

with recursive
gen(lvl, tmp, cnt, prefix) as
(
	select 1, 2::double precision, 0, 123
	union all
	select
		lvl+1,
		(case when tmp*2 >= 10*prefix then tmp*2/10 else tmp*2 end)::double precision,
		cnt + case when trunc(tmp) = prefix then 1 else 0 end,
		prefix
	from gen
	where cnt < 678910
)
select max(lvl) - 1 result
from gen;