with recursive
gen(lvl, str) as
(
	select 1, n::text
	from generate_series(1, 9) n
	union all
	select lvl + 1, str || n::text
	from gen, generate_series(1, 9) n
	where position(n::text in str) = 0
)
select sum(distinct right(str, 4)::int) result
from gen
where lvl = 9
and
(
	substr(str, 1, 1)::int * substr(str, 2, 4)::int = right(str, 4)::int
	or
	substr(str, 1, 2)::int * substr(str, 3, 3)::int = right(str, 4)::int
);