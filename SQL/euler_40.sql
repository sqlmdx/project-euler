with recursive
gen(lvl, len1, len2) as
(
	select 1, 1, 1
	union all
	select lvl + 1, len2 + 1, len2 + length((lvl + 1)::text)
	from gen
	where len1 < 1000000
)
select exp(sum(ln(substr(lvl::text, power(10, i)::int - len1 + 1, 1)::int)))::int
from gen g
join generate_series(0, 6) i on power(10, i)::int between len1 and len2;