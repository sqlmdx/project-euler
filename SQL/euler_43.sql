-- generates 10! rows and takes almost a minute to run on my laptop

with recursive
gen(lvl, str) as
(
	select 1, n::text
	from generate_series(0, 9) n
	union all
	select lvl + 1, str || n::text
	from gen, generate_series(0, 9) n
	where position(n::text in str) = 0
)
select sum(str::bigint) result
from gen
where lvl = 10
and substr(str, 2, 3)::int % 2 = 0
and substr(str, 3, 3)::int % 3 = 0
and substr(str, 4, 3)::int % 5 = 0
and substr(str, 5, 3)::int % 7 = 0
and substr(str, 6, 3)::int % 11 = 0
and substr(str, 7, 3)::int % 13 = 0
and substr(str, 8, 3)::int % 17 = 0;